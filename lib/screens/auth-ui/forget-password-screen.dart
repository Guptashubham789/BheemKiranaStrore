
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../../controllers/forgot-password-controller.dart';
import '../../utils/app-constant.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgotPasswordController forgotPasswordController=Get.put(ForgotPasswordController());
  TextEditingController userEmail=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            title: Text('Forget Password'),
            centerTitle: true,

            backgroundColor: AppConstant.appMainColor,
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                isKeyboardVisible?Text('Welcome To My App'):
                Column(
                  children: [
                    Lottie.asset('assets/images/splash-icon2.json',height: Get.height/3)
                  ],
                ),
                SizedBox(height: Get.height/60,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userEmail,
                        cursorColor: AppConstant.appMainColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.only(top: 20.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    )),
                SizedBox(height: Get.height/60,),


                Material(
                  child: Container(
                    width: Get.width/2,
                    height: Get.height/15,
                    decoration: BoxDecoration(
                        color: AppConstant.appMainColor,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: TextButton(
                      child: Text('Forget Password',style: TextStyle(color: AppConstant.appTextColor),),
                      onPressed: () async{
                        String email=userEmail.text.trim();

                        if(email.isEmpty){
                          Get.snackbar("Error", "please enter all details.");
                        }else{
                          forgotPasswordController.forgotPasswordMethod(email);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height/20,),


              ],
            ),
          ),
        );
      },
    );
  }
}
