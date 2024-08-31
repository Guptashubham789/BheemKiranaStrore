import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryapp/controllers/google-sign-in-controller.dart';
import 'package:groceryapp/screens/auth-ui/sign-in-screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignInController _googleSignInController=
  Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        elevation: 0,
        title: const Text('Welcome To The Grocery'),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/splash-icon2.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
                child: Text('Happy Shopping!!',style: TextStyle(fontFamily: AppConstant.appFontFamily),)),
            SizedBox(height: Get.height/12,),
            Material(
              child: Container(
                width: Get.width/1.3,
                height: Get.height/12,
                decoration: BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: TextButton.icon(
                 label: Text('Sign in with Google',style: TextStyle(color: AppConstant.appTextColor),),
                  onPressed: (){
                   _googleSignInController.signInWithGoogle();
                  },
                  icon: Image.asset('assets/images/google.png',width: Get.width/12,height: Get.height/12,),
                ),
              ),
            ),
            SizedBox(height: Get.height/20,),
            Material(
              child: Container(
                width: Get.width/1.3,
                height: Get.height/12,
                decoration: BoxDecoration(
                    color: AppConstant.appMainColor,
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: TextButton.icon(
                  label: Text('Sign in with Email',style: TextStyle(color: AppConstant.appTextColor),),
                  onPressed: (){
                    Get.to(()=> SignScreen());
                  },
                  icon: Image.asset('assets/images/gmail.png',width: Get.width/12,height: Get.height/12,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
