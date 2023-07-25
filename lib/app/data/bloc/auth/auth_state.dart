import 'package:jzeno_tea/app/model/user_model.dart';

abstract class AuthState  {}

class AuthLoadingState extends AuthState{
}

class AuthLoadedState extends AuthState{
  final UserModel? user;
  AuthLoadedState(this.user);
}

class AuthErorrState extends AuthState{
  String? message;
  AuthErorrState(this.message);
}

