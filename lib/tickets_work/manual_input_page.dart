// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/cubits/user_event_cubit.dart';
import 'package:ticketok/services/ticket_service.dart';
import 'package:ticketok/tickets_work/check_results/result.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../loader.dart';
import '../models/user.dart';
import '../models/user_event.dart';
import '../services/validation_service.dart';

class ManualInput extends StatefulWidget {
  const ManualInput({super.key});

  @override
  State <ManualInput> createState() => _ManualInputState();
}

class _ManualInputState extends State<ManualInput>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ticketIdController = TextEditingController();
   var maskFormatter = MaskTextInputFormatter(
    mask: '####-####-####',
    filter: { "#": RegExp(r'[A-Z]') },
  );


@override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User userData = context.watch<UserCubit>().state;
        // вот это вообще странно. типо весь этот кубит лежит в контексте и его можно вызывать только внутри билдера виджет билд
        final UserEvent? currentEvent = context.watch<UserEventCubit>().state;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Работа с билетами', style: TextStyle(fontSize: 24, color: Colors.white)),
            backgroundColor: Color.fromRGBO(33, 150, 243, 1),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Text("Введите ID билета",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        Text('и нажмите кнопку отправить',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: ticketIdController,
                                  decoration: const InputDecoration(hintText: 'ID билета'),
                                  validator: validateTicketId,
                                  inputFormatters: [maskFormatter],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
                                    fixedSize: const Size(245, 50)
                                  ),
                                  onPressed: () => submit(userData.accessToken, currentEvent!.id, context),
                                  child: const Text('ОТПРАВИТЬ', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(86, 204, 242, 1),
                                    fixedSize: const Size(245, 50)
                                  ),
                                  onPressed: () => {
                                    Navigator.pop(context)
                                  },
                                  child: const Text('Назад', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void submit(String accessToken, num id, BuildContext context111) async{

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, __, ___) => Loader(), opaque: false)
    );

    var ticketResult = await checkTicket(ticketIdController.text, id, accessToken);

    Navigator.pop(context);

    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, __, ___) => ScanResult(ticketCheckResponse: ticketResult,), opaque: false)
    );
    }
  }