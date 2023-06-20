import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';

class UserCubit extends Cubit<User>{
  UserCubit(User state) : super(state);

  void login(User user) => emit(user);

  void logout() => emit(User.empty());
}