import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ticketok/services/check_internet_connection_service.dart';

import '../scanner/scan_page.dart';

class TicketsWorkPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TicketsWorkPageState();

}

class _TicketsWorkPageState extends State<TicketsWorkPage>{

  late bool hasInternetConnection;

  late StreamSubscription<ConnectivityResult> hasNetworkSubscription;

  @override
  void initState() {
    super.initState();  
    hasInternetConnection = false;
    setAsyncTest();  

    hasNetworkSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState((){
      hasInternetConnection = checkInternetByConnectivityResult(result);   
      });
    });
  }

  Future setAsyncTest() async{
    var hasConnection = await checkInternetConnection();

    setState((){
      hasInternetConnection = hasConnection;   
    });
  }

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
            SizedBox(height: 230),
            Text(hasInternetConnection ? 'Отсканируйте билет' : 'Сканнер в offline', style: TextStyle(fontSize: 24)),
            Text(hasInternetConnection ? 'или введите ID вручную' : 'для продолжения работы подключите устройство к сети', style: TextStyle(fontSize: 16)),
            SizedBox(height: 100,),
            enterIdByHandsButton(),
            SizedBox(height: 15),
            openScannerButton(context)
          ]
        ),
      ),
    );
  }

  @resume

  ElevatedButton enterIdByHandsButton() {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
              fixedSize: const Size(245, 50)
            ),
            onPressed: hasInternetConnection 
            ? (){

            }
            : null,
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
            onPressed: hasInternetConnection
            ? (){
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => Scan(), opaque: false)
              );
            }
            : null,
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