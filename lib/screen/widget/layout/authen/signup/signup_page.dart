import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/extension/responsive_extention.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    fullnameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "SignIn");
                  },
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Text(
                      "${AppText.signInText.toUpperCase()} ?",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold),
                    )),
                  ))
            ],
          ),
        body: SingleChildScrollView(
          child: Responsive( desktop: buildSignUp(84.5, MediaQuery.of(context).size.width/4),
              tablet: buildSignUp(84.5, MediaQuery.of(context).size.width/8.6),
               mobile: buildSignUp(84.5, 10),),
      ));
  }

  Widget buildSignUp(double vertical, double horizontal) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 210, 215, 234),
              Color.fromARGB(255, 56, 135, 180),
              Color.fromARGB(255, 44, 108, 154),
              Color.fromARGB(255, 56, 135, 180),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white30),
            margin: EdgeInsets.symmetric(
                vertical: vertical, horizontal: horizontal),
            padding: const EdgeInsets.all(25),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 35, 35, 35),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.textFiled(context, fullnameController,
                      AppText.fullname, Icons.star),
                  AppText.textFiled(context, userNameController,
                      AppText.userName, Icons.person),
                  AppText.textFiled(
                      context, passwordController,"Password ", Icons.lock,
                      obscure: true),
                  AppText.textFiled(context, confirmPasswordController,
                      AppText.confirmPassText, Icons.lock,
                      obscure: true),
                      const SizedBox(height: 40,),
                  AppButton().btnSubmit(context, "Sign Up",() {
                  })
                ],
              ),
            )));
  }
}