import 'package:flutter/material.dart';
import 'package:ticketok/scanner/scan_page.dart';

class StartDutyButton extends StatelessWidget{
  const StartDutyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Чтобы начать работу, нажмите кнопку ниже",
            style: TextStyle(fontSize: 13), 
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor:const Color.fromRGBO(46, 125, 50, 1),
              shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))
            ),
            onPressed: (){
              Navigator.pushNamed(context, "/tickets_work");
            }, 
            child: const Text('Начать смену',style: TextStyle(fontSize: 18, color: Colors.white),)
          )
        ],
      ),
    );
  }
}