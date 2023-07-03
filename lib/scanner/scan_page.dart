// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../cubits/user_cubit.dart';
import '../cubits/user_event_cubit.dart';
import '../models/user.dart';
import '../models/user_event.dart';
import '../services/ticket_service.dart';
import '../tickets_work/check_results/result.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State <Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan>{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashStatus = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

@override
  Widget build(BuildContext context) {      
    final User userData = context.watch<UserCubit>().state;
    final UserEvent? currentEvent = context.watch<UserEventCubit>().state;   

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              child: SizedBox(
                child: Column(
                  children: [
                    Text("Сканер",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text('поместите штрих-код в рамку',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                borderRadius:const BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                )
              ),
              width: 210.0,
              height: 210.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(16.0)),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    )
                  ),
                  width: 190.0,
                  height: 190.0,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (QRViewController controller) => _onQRViewCreated(controller, currentEvent!.id, userData.accessToken),
                    overlayMargin: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height:50,
                    width: 50,
                    child:FloatingActionButton(
                    backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //border radius equal to or more than 50% of width
                    ),
                    onPressed: toggleFlashlight,
                    child: flashStatus
                    ? Icon(
                      Icons.flashlight_off,
                      color: Colors.white
                    )
                    : Icon(
                      Icons.flashlight_on,
                      color: Colors.white
                    ),
                  ),
                 ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
                      fixedSize: const Size(245, 50)
                    ),
                    onPressed: () => {},
                    child: const Text('ВВЕСТИ ID ВРУЧНУЮ', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    )),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    minimumSize: Size.fromHeight(80),
                    shape: const ContinuousRectangleBorder(),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Вернуться назад", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                ),
              ],
            ),
            Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            )
          ],
        ),
      ),
    );
  }

void _onQRViewCreated(QRViewController controller, num eventId, String accessToken) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {

      if(scanData.format != BarcodeFormat.qrcode){
        return;
      }
      
      controller.pauseCamera();
      var ticketResult = await checkTicket(scanData.code!, eventId, accessToken);

      setState(() {
        result = scanData;
      });
      
      Navigator.of(context).pop();
      Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (_, __, ___) => ScanResult(ticketCheckResponse: ticketResult,), opaque: false)
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void toggleFlashlight() async{
    await controller?.toggleFlash();
    var flashStatusResult = (await controller!.getFlashStatus())!;

    setState((){
      flashStatus = flashStatusResult;
    });
  }
}

