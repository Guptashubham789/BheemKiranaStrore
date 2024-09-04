import 'package:flutter/material.dart';
import 'package:groceryapp/utils/app-constant.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("User Profile",style: TextStyle(fontFamily: AppConstant.appFontFamily,color: AppConstant.appTextColor),),
      ),
      body: Text("SSG!!"),
    );
  }
}
