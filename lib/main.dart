import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/config/theme_config.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/routes/app_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>ProductCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme ,
        darkTheme: AppTheme.blackTheme,
        themeMode: ThemeMode.system,
        initialRoute: "Tab_Tablet",
        onGenerateRoute: AppRoute.onGenerateRoute,
      )
    );
  }
}
