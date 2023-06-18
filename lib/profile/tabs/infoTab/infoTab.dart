import 'package:flutter/material.dart';
// import 'package:ticketok/page-1/.dart';
//import 'package:ticketok/page-1/-1Ve.dart'; // мусор
// import 'package:ticketok/utils.dart';
// import 'package:ticketok/page-1/-YQ4.dart';
// import 'package:ticketok/page-1/telegram-cloud-photo-size-2-5402465158221118499-y-1.dart';
// import 'package:ticketok/page-1/-ECk.dart';
// import 'package:ticketok/page-1/-Swe.dart';
// import 'package:ticketok/page-1/-41A.dart';
// import 'package:ticketok/page-1/-ij6.dart';
// import 'package:ticketok/page-1/-nAQ.dart';
// import 'package:ticketok/page-1/-EsW.dart';
// import 'package:ticketok/page-1/-ANQ.dart';
// import 'package:ticketok/page-1/-HgY.dart';
// import 'package:ticketok/page-1/type-not-allowed.dart';
// import 'package:ticketok/page-1/type-not-found.dart';
// import 'package:ticketok/page-1/type-re-entry.dart';
// import 'package:ticketok/page-1/loader.dart';
// import 'package:ticketok/page-1/offline-.dart';
// import 'package:ticketok/page-1/-kbW.dart';
// import 'package:ticketok/page-1/logoutwhite24dp-1.dart';
// import 'package:ticketok/page-1/-RQg.dart';
// import 'package:ticketok/page-1/-2jE.dart';
// import 'package:ticketok/page-1/-Mpg.dart';
// import 'package:ticketok/page-1/telegram-cloud-photo-size-2-5474171831956127572-y-1.dart';
// import 'package:ticketok/page-1/telegram-cloud-photo-size-2-5474171831956127571-y-1.dart';
// import 'package:ticketok/page-1/telegram-cloud-photo-size-2-5474171831956127573-y-1.dart';
// import 'package:ticketok/page-1/telegram-cloud-photo-size-2-5411199833210994337-y-1.dart';
// import 'package:ticketok/page-1/-GEg.dart';
// import 'package:ticketok/page-1/api-.dart';
// import 'package:ticketok/page-1/api--pFW.dart';
// import 'package:ticketok/page-1/-FGG.dart';
// import 'package:ticketok/page-1/-rSQ.dart';
// import 'package:ticketok/page-1/-1Ve.dart';
// import 'package:ticketok/page-1/-aj6.dart';
// import 'package:ticketok/page-1/frame-37361.dart';
// import 'package:ticketok/page-1/bbbb-bbbb-bbbb-cccc-cccc-cccc-dddd-dddd-dddd-.dart';


class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
  });

  @override
  // Widget build(BuildContext context) {
	// return MaterialApp(
	// 	title: 'Flutter',
	// 	debugShowCheckedModeBanner: false,
	// 	scrollBehavior: MyCustomScrollBehavior(),
	// 	theme: ThemeData(
	// 	primarySwatch: Colors.blue,
	// 	),
	// 	home: Scaffold(
	// 	body: SingleChildScrollView(
	// 		child: Scene(),
	// 	),
	// 	),
	// );
	// }
    Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, "/scan");
        }, 
        child: const Text('go to scan')),
        Chip(
          label: const Text('Aaron Burr'),
        ),
      ],
    );
  }
}