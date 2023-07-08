import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/user_event.dart';

class UserEventCubit extends Cubit<UserEvent?>{
  UserEventCubit(UserEvent? state) : super(state);

  Future setCurrentEvent(UserEvent event) async{
    var userEventBox = await Hive.openBox<UserEvent>('user_event');
    userEventBox.add(event);

    emit(event);
  }

  Future clearEvent() async{
    var userEventBox = await Hive.openBox<UserEvent>('user_event'); 
    userEventBox.clear();

    emit(null);
  } 
}