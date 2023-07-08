import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';

class UserCubit extends Cubit<User>{
  UserCubit(User state) : super(state);

  Future login(User user) async {
    var userBox = await Hive.openBox<User>('user');
    userBox.add(user);

    emit(user);
  }

  Future logout() async{
    var userBox = await Hive.openBox<User>('user');
    userBox.clear();

    emit(User.empty());
  }
}