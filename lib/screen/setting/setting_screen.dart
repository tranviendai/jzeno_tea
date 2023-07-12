import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/setting/bloc/setting_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isChangeColor = false;
  void toggleTheme() {
    context.read<SettingCubit>().toggleTheme();
    setState(() {
      isChangeColor = !isChangeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Me"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: toggleTheme,
                icon: !isChangeColor
                    ? const Icon(
                        Icons.sunny,
                        color: Colors.amberAccent,
                      )
                    : const Icon(
                        Icons.brightness_3,
                        color: Colors.amberAccent,
                      ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              itemApp(context, AppText.myCartText, func: () {
                Navigator.pushNamed(context, "Cart");
              }),
              itemApp(context, AppText.logoutText, icon: Icons.logout,
                  func: () {
                // Navigator.pop(context);
              }),
            ],
          ),
        ));
  }

  Widget itemApp(BuildContext context, String text,
      {IconData? icon, Function()? func}) {
    return InkWell(
      onTap: () {
        func!();
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration:
              BoxDecoration(color: Theme.of(context).primaryColor, boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Theme.of(context).cardColor,
                offset: const Offset(0, 0.4))
          ]),
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppText.h1,
              ),
              Icon(icon),
            ],
          )),
    );
  }
}
