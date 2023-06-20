import 'authModel.dart';

class AuthResponse{
  final String? error;
  final User? user;

  AuthResponse({this.error, this.user});
}