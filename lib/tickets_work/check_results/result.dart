// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticketok/models/ticket_check_transaction.dart';
import 'package:ticketok/tickets_work/manual_input_page.dart';
import '../../cubits/user_cubit.dart';
import '../../cubits/user_event_cubit.dart';
import '../../endWorkButton.dart';
import '../../loader.dart';
import '../../models/ticket_check_response.dart';
import '../../models/user.dart';
import '../../models/user_event.dart';
import '../../scanner/scan_page.dart';
import '../../services/ticket_service.dart';
import '../../services/validation_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



class ScanResult extends StatefulWidget {
  final TicketCheckResponse ticketCheckResponse;
  const ScanResult({super.key, required this.ticketCheckResponse});

  @override
  State <ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ticketIdController = TextEditingController();

  late TicketCheckResponse ticketCheckResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketCheckResponse = widget.ticketCheckResponse;
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '####-####-####',
    filter: { "#": RegExp(r'[A-Z0-9]') },
  );

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EndWorkButton(context: context),
            Column(
              children: [
                icon(ticketCheckResponse.isValid),
                SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
                  padding: EdgeInsets.all(10),
                  child: text(ticketCheckResponse)
                ),
              ],
            ),
            SizedBox(
              width: 350,
              child: content(ticketCheckResponse, userData.accessToken, currentEvent!.id)
            ),
            SizedBox(
              child: !ticketCheckResponse.isValid
                ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: goBackButton(context),
                )
                : null
            )
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

  // switch (ticketCheckResponse.errorType) { // todo - переделать на Enum ErrorType
  //   case ErrorType.notAllowed:
  //     title = "Невалидный билет";
  //     break;
  //   case ErrorType.reEntry:
  //     title = "Повторный вход";
  //     break;
  //   case ErrorType.notFound:
  //     title = "Билет не найден";
  //     break;
  //   default:
  //     title = "Билет не найден";
  // }

  title = ticketCheckResponse.errorMessage!;
  subTitle = ticketCheckResponse.errorMessageFriendly!;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text(title, style: TextStyle(fontSize: 24)),
    Text(subTitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, )),
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
    case ErrorType.notAllowed:
      child = null;
    case ErrorType.reEntry:
      child = Column(
        children: [
          const Text('Транзакции', style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          )),
          transactions(ticketCheckResponse.transactions),
        ],
      );
    case ErrorType.notFound:
      child = repeat(accessToken, id, ticketCheckResponse.ticket);
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
    return  Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(DateFormat("dd-MM hh:mm:ss").format(i.datetime), style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(i.title.toString(), style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          )),
        ),
        i.operatorId != null && i.operatorName != null
        ? Text("( ${i.operatorId} ${i.operatorName} )", style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          ))
        : Text(""),
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
              inputFormatters: [maskFormatter],
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

    // Navigator.pop(context);

    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, __, ___) => Loader(), opaque: false)
    );

    var ticketResult = await checkTicket(ticketIdController.text, id, accessToken, context);

    setState(() {
      ticketCheckResponse = ticketResult;
    });

    Navigator.pop(context);

    // Navigator.of(context).push(
    //   PageRouteBuilder(pageBuilder: (_, __, ___) => ScanResult(ticketCheckResponse: ticketResult,), opaque: false)
    // );
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
            child: FittedBox(
              child: const Text('ВВЕСТИ ID ВРУЧНУЮ', style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )),
            ),
          );
  }

  ElevatedButton openScannerButton(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
              fixedSize: const Size(245, 50)
            ),
            onPressed:  (){

              Navigator.popUntil(context, ModalRoute.withName("/tickets_work"));

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