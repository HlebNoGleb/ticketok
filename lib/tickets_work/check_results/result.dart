// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticketok/models/ticket_check_transaction.dart';
import 'package:ticketok/tickets_work/manual_input_page.dart';
import '../../cubits/user_cubit.dart';
import '../../cubits/user_event_cubit.dart';
import '../../models/ticket_check_response.dart';
import '../../models/user.dart';
import '../../models/user_event.dart';
import '../../scanner/scan_page.dart';
import '../../services/ticket_service.dart';
import '../../services/validation_service.dart';

class ScanResult extends StatefulWidget {
  final TicketCheckResponse ticketCheckResponse;
  const ScanResult({super.key, required this.ticketCheckResponse});

  @override
  State <ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult>{

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ticketIdController = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User userData = context.watch<UserCubit>().state;
        // вот это вообще странно. типо весь этот кубит лежит в контексте и его можно вызывать только внутри билдера виджет билд
        final UserEvent? currentEvent = context.watch<UserEventCubit>().state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Работа с билетами', style: TextStyle(fontSize: 24, color: Colors.white)),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            endWorkButton(context),
            SizedBox(height: 200),
            icon(widget.ticketCheckResponse.isValid),
            SizedBox(height: 20),
            text(widget.ticketCheckResponse),
            SizedBox(height: 100,),
            content(widget.ticketCheckResponse, userData.accessToken, currentEvent!.id),
            SizedBox(child: !widget.ticketCheckResponse.isValid ? goBackButton(context) : null)
          ]
        ),
      ),
      );
      }
    );
  }

Column text(TicketCheckResponse ticketCheckResponse) {
  const successTitle = 'Наденьте гостю браслет.';
  const successSubTitle = 'Вход разрешён';

  if (ticketCheckResponse.isValid){
    return Column(children: [
      Text(successTitle, style: TextStyle(fontSize: 24)),
      Text(successSubTitle, style: TextStyle(fontSize: 16)),
    ]);
  }

  var title = "";
  var subTitle = "";

  switch (ticketCheckResponse.errorType) { // todo - переделать на Enum ErrorType
    case "not-allowed":
      title = "Невалидный билет";
      subTitle = "Категория билета не соответствует разрешённым для данного сканера. Объясните гостю, где он может обменять свой билет.";
    case "re-entry":
      title = "Повторный вход";
      subTitle = "Откажите гостю во входе, объяснив ситуацию. При необходимости, пригласите менеджера входной группы.";
    case "not-found":
      title = "Билет не найден";
      subTitle = "Возможно, билет подделан. Проверьте ещё раз, при необходимости позовите менеджера.";
      break;
    default:
      title = "Билет не найден";
      subTitle = "Возможно, билет подделан. Проверьте ещё раз, при необходимости позовите менеджера.";
  }

  return Column(children: [
    Text(title, style: TextStyle(fontSize: 24)),
    Text(subTitle, style: TextStyle(fontSize: 16)),
  ]);
}

SizedBox icon(bool isValid) {
  return SizedBox(
      height:70,
      width: 70,
      child:FloatingActionButton(
      backgroundColor: isValid ? const Color.fromRGBO(42, 184, 73, 1) : const Color.fromRGBO(210, 9, 57, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          //border radius equal to or more than 50% of width
      ),
      onPressed: null,
      child: isValid
      ? Icon(
        Icons.check,
        color: Colors.white,
        size: 40,
      )
      : Icon(
        Icons.lock,
        color: Colors.white,
        size: 40,
      )
    ),
  );
}

SizedBox content (TicketCheckResponse ticketCheckResponse, String accessToken, num id) {

  if (ticketCheckResponse.isValid){
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          enterIdByHandsButton(),
          SizedBox(height: 15),
          openScannerButton(context)
        ],
      )
    );
  }

  var child;

  switch (ticketCheckResponse.errorType) { // todo - переделать на Enum ErrorType
    case "not-allowed":
      child = null;
    case "not-found":
      child = Column(
        children: [
          const Text('Транзакции', style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          )),
          transactions(ticketCheckResponse.transactions),
        ],
      );
    // case "not-found":
    //   child = repeat(accessToken, id, ticketCheckResponse.ticket);
      break;
    default:
      child = null;
  }

  return SizedBox(
    height: 250,
    child: child
  );
}

Column transactions (List<TicketCheckTransaction>? transactions){
  if (transactions == null) {
    return Column();
  }

  return Column(children: transactions.map((i) {
    return Row(
      children: [
        Text(i.datetime.toString()),
        Text(i.title.toString()),
        Text("(${i.operatorId}${i.operatorName})"),
      ],
    );
  }).toList());
}

SizedBox repeat(String accessToken, num id, String ticket){
  ticketIdController.text = ticket;
  return SizedBox(
    width: 250,
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: ticketIdController,
              decoration: const InputDecoration(hintText: 'ID билета'),
              validator: validateTicketId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                fixedSize: const Size(245, 50)
              ),
              onPressed: () => submit(accessToken, id, context),
              child: const Text('Повторить', style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )),
            ),
          ),
        ],
      ),
    ),
  );
}

  void submit(String accessToken, num id, BuildContext context111) async{

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(context);

    var ticketResult = await checkTicket(ticketIdController.text, id, accessToken);
      Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (_, __, ___) => ScanResult(ticketCheckResponse: ticketResult,), opaque: false)
      );
    }

ElevatedButton enterIdByHandsButton() {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
              fixedSize: const Size(245, 50)
            ),
            onPressed: (){
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => ManualInput(), opaque: false)
              );
            },
            child: const Text('ВВЕСТИ ID ВРУЧНУЮ', style: TextStyle(
              color: Colors.white,
              fontSize: 18
            )),
          );
  }

  ElevatedButton openScannerButton(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
              fixedSize: const Size(245, 50)
            ),
            onPressed:  (){
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => Scan(), opaque: false)
              );
            },
            child: const Text('ОТКРЫТЬ СКАННЕР', style: TextStyle(
              color: Colors.white,
              fontSize: 18
            )),
          );
  }

  ElevatedButton endWorkButton(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              minimumSize: Size.fromHeight(80),
              shape: const ContinuousRectangleBorder()
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("ЗАВЕРШИТЬ СМЕНУ", style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            )),
          );
  }

  ElevatedButton goBackButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        fixedSize: const Size(245, 50)
      ),
      onPressed: (){
        Navigator.pop(context);
      },
      child: const Text("Назад", style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      )),
    );
  }
}
