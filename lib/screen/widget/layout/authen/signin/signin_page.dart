import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_cubit.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/extension/responsive_extention.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isCheck = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void showPass() {
    setState(() {
      _isCheck = !_isCheck;
    });
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
                  Navigator.pushNamed(context, "SignUp");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                      child: Text(
                    "${AppText.signUpText.toUpperCase()} ?",
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold),
                  )),
                ))
          ],
        ),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Responsive(
              desktop: buildLogin(
                  84.5, MediaQuery.of(context).size.width / 4, "Home"),
              tablet: buildLogin(
                  84.5, MediaQuery.of(context).size.width / 8.6, "Home"),
              mobile: buildLogin(84.5, 10, "Home"),
            )));
  }

  Widget buildLogin(double vertical, double horizontal, String text) {
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
          margin:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          padding: const EdgeInsets.all(25),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 35, 35, 35),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.textFiled(
                    context, username, AppText.userName, Icons.person),
                AppText.textFiled(
                  context,
                  password,
                  obscure: _isCheck,
                  AppText.passText,
                  Icons.lock,
                  showPass: (context) {
                    showPass();
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppText.forgotPassText,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
                AppButton().btnSubmit(context, "Sign In", () {
                  APIRepository().login(username.text, password.text);
                  String token = AuthCubit.token;
                  if (token.isNotEmpty) {
                    
                    Navigator.pushNamed(context, text);
                  }
                }),
                const SizedBox(height: 50),
                AppButton().buttonRoute(context, AppText.fbText,
                    color: AppColor.black50percentColor,
                    image: Image.asset(AppImage.iconFB, height: 18)),
                const SizedBox(height: 10),
                AppButton().buttonRoute(context, AppText.ggText,
                    color: AppColor.black50percentColor,
                    image: Image.asset(AppImage.iconGG, height: 18))
              ],
            ),
          ),
        ));
  }
}
