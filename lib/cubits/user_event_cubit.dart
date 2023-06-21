import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_event.dart';

class UserEventCubit extends Cubit<UserEvent?>{
  UserEventCubit(UserEvent? state) : super(state);

  void setCurrentEvent(UserEvent event) => emit(event);

  void clearEvent() => emit(null);
}