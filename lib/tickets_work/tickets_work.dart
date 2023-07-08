import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ticketok/tickets_work/manual_input_page.dart';
import 'package:ticketok/services/check_internet_connection_service.dart';

import '../cubits/user_cubit.dart';
import '../cubits/user_event_cubit.dart';
import '../endWorkButton.dart';
import '../models/user.dart';
import '../models/user_event.dart';
import '../scanner/scan_page.dart';

class TicketsWorkPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TicketsWorkPageState();

}

class _TicketsWorkPageState extends State<TicketsWorkPage>{

  late bool hasInternetConnection;
  late bool isOfflineMode;

  late StreamSubscription<ConnectivityResult> hasNetworkSubscription;

  @override
  void initState() {
    super.initState();
    hasInternetConnection = false;
    isOfflineMode = false;
    setAsyncTest();
    setIsOfflineMode();

    hasNetworkSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState((){
      hasInternetConnection = checkInternetByConnectivityResult(result);
      });
    });
  }

  void setIsOfflineMode() async {
    var appSettingsBox = await Hive.openBox<bool>('app_settings');

    var isOfflineModeFromBox = appSettingsBox.get('isOffline') ?? false;

    setState(() {
      isOfflineMode = isOfflineModeFromBox;
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

    final User userData = context.watch<UserCubit>().state;
    final UserEvent? currentEvent = context.watch<UserEventCubit>().state;

    return WillPopScope(
      onWillPop: () async {
        return await EndWorkButton.endWorkWithConfirm(context, userData, currentEvent);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Работа с билетами', style: TextStyle(fontSize: 24, color: Colors.white)),
          backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EndWorkButton(context: context),
              SizedBox(height: 230),
              Text(hasInternetConnection && !isOfflineMode ? 'Отсканируйте билет' : 'Сканнер в offline', style: TextStyle(fontSize: 24)),
              Text(hasInternetConnection && !isOfflineMode ? 'или введите ID вручную' : 'для продолжения работы подключите устройство к сети', style: TextStyle(fontSize: 16)),
              SizedBox(height: 100,),
              enterIdByHandsButton(),
              SizedBox(height: 15),
              openScannerButton(context)
            ]
          ),
        ),
      ),
    );
  }

  ElevatedButton enterIdByHandsButton() {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
              fixedSize: const Size(245, 50)
            ),
            onPressed: hasInternetConnection && !isOfflineMode
            ? (){
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => ManualInput(), opaque: false)
              );
            }
            : null,
            child: const FittedBox(
              child: Text('ВВЕСТИ ID ВРУЧНУЮ', style: TextStyle(
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
            onPressed: hasInternetConnection && !isOfflineMode
            ? (){
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (_, __, ___) => Scan(), opaque: false)
              );
            }
            : null,
            child: const FittedBox(
              child: Text('ОТКРЫТЬ СКАННЕР', style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )),
            ),
          );
  }

}