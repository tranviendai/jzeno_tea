import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/screen/cart/bloc/cart_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/topping/topping_cubit.dart';
import 'package:jzeno_tea/app/routes/app_route.dart';
import 'package:jzeno_tea/screen/setting/bloc/setting_bloc.dart';

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
        BlocProvider(create: (context) =>CategoryCubit()),
        BlocProvider(create: (context) => ToppingCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) =>SettingCubit())
      ],
      child: BlocBuilder<SettingCubit,ThemeData>(
        builder: (context,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state,
          // darkTheme: AppTheme.blackTheme,
          // themeMode: ThemeMode.system,
          initialRoute: "/",
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      )
    );
  }
}
