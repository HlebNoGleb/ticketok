// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'changeEvent.dart';
import 'package:ticketok/models/authModel.dart';

class MainTab extends StatefulWidget {
  final User? userModel;
  const MainTab({super.key, required this.userModel});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  String eventName = "111";
  late User userModel;

  @override
  void initState() {
    super.initState();
    eventName = widget.userModel!.full_name;
    userModel = widget.userModel!;
  }

  void changeEventName(String newName){
    setState((){
      eventName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color:  Color.fromRGBO(229, 246, 253, 1),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.info_outline, color: Colors.indigo),
                        ),
                        // Text(eventName,
                        // style: TextStyle(color: Colors.indigo), overflow: TextOverflow.fade, maxLines: 1, softWrap: true,),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(right: 13.0),
                            child: Text(
                              eventName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ChangeEvent(notifyParent: changeEventName)
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  child: SizedBox.fromSize(
                  size: Size.fromRadius(25), // Image radius
                  child: Image.network(userModel.access_token))
                ),
              ),
              Flexible(
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start ,children: [
                  Text(userModel.url_photo, overflow: TextOverflow.ellipsis,),
                  Text(userModel.full_name, overflow: TextOverflow.ellipsis,),
                ],),
              )
          ])
        ,),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Разрешенные сектора"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: degenerateSectorChips(userModel.events),),
                )
              ],
            ),
          )
        ),
      ],
    );
  }

  List<Widget> degenerateSectorChips(List<UserEvent> events) {

    return <Widget>[
      for(final item in events) Chip(label: Text(item.title)),
    ];
  }
}