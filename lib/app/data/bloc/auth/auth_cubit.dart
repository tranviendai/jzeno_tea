import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState());
  static String token = "";
  APIRepository authRepo = APIRepository();

  void getUsers() async {
    try {
      UserModel user = await authRepo.getUser();
      emit(AuthLoadedState(user));
    } catch (ex) {
      emit(AuthErorrState(ex.toString()));
    }
  }
}
