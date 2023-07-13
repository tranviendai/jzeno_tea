import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/desktop_responsive/home/home_screen.dart';
import 'package:jzeno_tea/screen/widget/layout/setting/setting_screen.dart';

class TabDesktop extends StatefulWidget {
  const TabDesktop({super.key});

  @override
  State<TabDesktop> createState() => _TabDesktopState();
}

class _TabDesktopState extends State<TabDesktop> {
  int selectIndex = 0;
  onChangeTab(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 1,
            child: Card(
              color: Theme.of(context).primaryColor,
              elevation: 2,
              child: Center(
                  child: Column(
                children: [
                  Container(
                    color: AppColor.blueColor,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Image(
                              image: AssetImage(AppImage.logo),
                              height: 100,
                            )),
                        Text(
                          AppText.welcomeHeader.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  selectItem("Home", 0),
                  selectItem("Product", 1),
                  selectItem("Users", 2),
                ],
              )),
            )),
        Expanded(
            flex: 5,
            child: selectIndex == 0
                ? const HomeScreen()
                : selectIndex == 1
                    ? const SettingScreen()
                    // : selectIndex == 3 ? const ProductScreen()
                    : Container())
      ],
    ));
  }

  Widget selectItem(String title, int index) {
    return InkWell(
      onTap: () {
        onChangeTab(index);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: selectIndex == index ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: selectIndex == index
                  ? Colors.white
                  : Theme.of(context).scaffoldBackgroundColor !=
                          AppColor.scafflodBgColor
                      ? Colors.white
                      : Colors.black,
              fontSize: 18),
        )),
      ),
    );
  }
}
