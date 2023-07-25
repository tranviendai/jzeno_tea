import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = UserModel();
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
                title: Text("Profile",style: AppText.h0,),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              child:CircleAvatar(
                                  backgroundImage: NetworkImage(user.image!),
                                  radius: 60)),
            Text(user.userName!,style:AppText.h0),
            profile01()
          ],
        ),
      ),
    );
    
  }
 Widget textRich(String label,String text){
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
        children: [
          TextSpan(text: label,style: AppText.h2),
          TextSpan(text: text, style: AppText.h1)
        ]
      )),
    );
  }
  Widget textRow(String label, String text){
    return Row(children: [
      textRich(label,text),
    ]);
  }
  Widget profile01(){
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2)
      ),
      child: Column(
        children: [
        textRow("ID: ",user.id!.substring(0, 24) + "..."),
         textRow("FullName: ",user.fullName!),
        textRow("PhoneNumber: ", user.phoneNumber!)
        ],
      ),
    );
  }
 
}
