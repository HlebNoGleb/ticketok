// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticketok/tickets_work/manual_input_page.dart';
import '../../models/ticket_check_response.dart';
import '../../scanner/scan_page.dart';

class ScanResult extends StatefulWidget {
  final TicketCheckResponse ticketCheckResponse;
  const ScanResult({super.key, required this.ticketCheckResponse});

  @override
  State <ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult>{

@override
  Widget build(BuildContext context) {
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
            enterIdByHandsButton(),
            SizedBox(height: 15),
            openScannerButton(context)
          ]
        ),
      ),
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
  ]);;
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
}