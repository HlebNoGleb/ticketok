import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkedHours extends StatelessWidget{
  final num totalHours;

  const WorkedHours({super.key, required this.totalHours});

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: totalHours.toInt());

    return Container(
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(
              color: const Color.fromRGBO(2, 136, 209, 1),
              width: 1.0
              )
          ),
          width: double.infinity,
          height: 50.0,
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,              
            children: [
              const Icon(Icons.schedule, color: Color.fromRGBO(2, 136, 209, 1)),
              const SizedBox(width: 16.0),
              Text(pluralFromDuration(duration),
                style: const TextStyle(
                    color: Color.fromRGBO(2, 136, 209, 1),
                    fontSize: 16.0
                ),                  
              ),
            ],
          ),
          );
  }

  String pluralFromDuration(Duration duration){
    return '${pluralHoursFromDuration(duration.inHours)} ${pluralMinutesFromDuration(duration.inMinutes.remainder(60))} ${pluralSecondsFromDuration(duration.inSeconds.remainder(60))}';
  }

  String pluralHoursFromDuration(int hours){
    return '$hours ${Intl.plural(hours, other: "часов", one: "час", few: "часа", locale: 'ru')}';
  }

  String pluralMinutesFromDuration(int minutes){
    return '$minutes ${Intl.plural(minutes, other: "минут", one: "минута", few: "минуты", locale: 'ru')}';
  }

  String pluralSecondsFromDuration(int seconds){
    return '$seconds ${Intl.plural(seconds, other: "секунд", one: "секунда", few: "секунды", locale: 'ru')}';
  }
}

