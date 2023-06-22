import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/profile/tabs/start_duty_button.dart';
import 'package:ticketok/services/user_event_service.dart';
import '../../../cubits/user_event_cubit.dart';
import '../../../models/user_event_info.dart';
import 'change_event.dart';
import 'package:ticketok/models/user.dart';

class MainTab extends StatefulWidget {
  final User? userModel;

  MainTab({super.key, required this.userModel});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  late UserEventInfo currentEvent;
  late User userModel;

  @override
  void initState() {
    super.initState();
    currentEvent = widget.userModel!.events.first;
    userModel = widget.userModel!;
  }

  void changeEvent(UserEventInfo eventInfo) async{

    var event = await GetEventById(eventInfo.id, userModel.accessToken);

    BlocProvider.of<UserEventCubit>(context).setCurrentEvent(event);

    setState((){
      currentEvent = eventInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color:  const Color.fromRGBO(229, 246, 253, 1),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:Icon(Icons.info_outline, color: Colors.indigo),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Text(
                              currentEvent.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ChangeEvent(changeEvent: changeEvent, events: userModel.events, currentEvent: currentEvent)
                ],
              ),
            ),
          ),
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
                    children: generateSectorChips(userModel.events),),
                )
              ],
            ),
          ),
          const StartDutyButton()
        ],
      ),
    );
  }

  List<Widget> generateSectorChips(List<UserEventInfo> events) {
    return <Widget>[
      for(final item in events) Chip(label: Text(item.title)),
    ];
  }
}