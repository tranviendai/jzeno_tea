import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/config/theme_config.dart';

class SettingCubit extends Cubit<ThemeData>{
  SettingCubit(): super(AppTheme.blackTheme);

  void toggleTheme(){
    if(state == AppTheme.lightTheme){
      emit(AppTheme.blackTheme);
    }
    else{
      emit(AppTheme.lightTheme);
    }
  }
}