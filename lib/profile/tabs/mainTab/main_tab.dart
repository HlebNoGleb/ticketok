import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/endWorkButton.dart';
import 'package:ticketok/models/user_event.dart';
import 'package:ticketok/profile/tabs/start_duty_button.dart';
import 'package:ticketok/services/user_event_service.dart';
import '../../../cubits/user_event_cubit.dart';
import '../../../models/user_event_info.dart';
import 'change_event.dart';
import 'package:ticketok/models/user.dart';

class MainTab extends StatefulWidget {
  final User? userModel;
  final UserEvent? currentEvent;

  MainTab({super.key, required this.userModel, required this.currentEvent});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  late UserEventInfo currentEventInfo;
  late User userModel;
  // late UserEvent? currentEvent;

  @override
  void initState() {
    super.initState();
    currentEventInfo = widget.userModel!.events.first;
    userModel = widget.userModel!;
    // currentEvent = widget.currentEvent;
  }

  void changeEvent(UserEventInfo eventInfo) async{

    var event = await GetEventById(eventInfo.id, userModel.accessToken);

    BlocProvider.of<UserEventCubit>(context).setCurrentEvent(event);

    setState((){
      currentEventInfo = eventInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserEvent? currentEvent = context.watch<UserEventCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(
          //   color:  const Color.fromRGBO(229, 246, 253, 1),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           child: Row(
          //             children: [
          //               const Padding(
          //                 padding: EdgeInsets.only(right: 10),
          //                 child:Icon(Icons.info_outline, color: Colors.indigo),
          //               ),
          //               Flexible(
          //                 child: Container(
          //                   padding: const EdgeInsets.only(right: 13.0),
          //                   child: Text(
          //                     currentEventInfo.title,
          //                     overflow: TextOverflow.ellipsis,
          //                     style: const TextStyle(color: Colors.indigo),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         ChangeEvent(changeEvent: changeEvent, events: userModel.events, currentEvent: currentEventInfo)
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 16.0),
          Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  child: SizedBox.fromSize(size: const Size.fromRadius(25))
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Text(userModel.fullName, overflow: TextOverflow.ellipsis,),
                    Text('Оператор №${userModel.operatorId}', overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
          ]),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Разрешенные сектора"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: generateSectorChips(currentEvent),),
                )
              ],
            ),
          ),
          StartDutyButton(context: context),
        ],
      ),
    );
  }

  List<Widget> generateSectorChips(UserEvent? userEvent) {
    if(userEvent == null){
      return List<Widget>.empty();
    }

    return <Widget>[
      for(final item in userEvent!.permitedZones) Chip(label: Text(item)),
    ];
  }
}