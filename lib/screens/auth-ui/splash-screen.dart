import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryapp/controllers/get-user-data-controller.dart';
import 'package:groceryapp/screens/admin-panel/admin-main-screen.dart';
import 'package:groceryapp/screens/user-panel/main-screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';
import 'welcome-screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      loggdin(context);
    });
  }
  Future<void> loggdin(BuildContext context) async{
    if(user!=null){
      final GetUserDataController getUserDataController=Get.put(GetUserDataController());
      //agr user ne login kiya hai to 
      var userData=await getUserDataController.getUserData(user!.uid);
        if(userData[0]['isAdmin']==true){
          Get.offAll(()=>AdminMainScreen());
        }else{
          //userscreen
          Get.offAll(()=>MainScreens());
        }
    }else{
      //agr user hmara login nhi kiya hai to hum usko bhej denge welcome screen pe
      Get.to(()=>WelcomeScreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      appBar: AppBar(
        title: Text(AppConstant.appName),
        backgroundColor: AppConstant.appMainColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/splash-icon2.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(AppConstant.appPoweredBy,
                style: TextStyle(
                    fontFamily: AppConstant.appFontFamily,
                    color: AppConstant.appTextColor,
                    fontWeight:FontWeight.bold,
                    fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
