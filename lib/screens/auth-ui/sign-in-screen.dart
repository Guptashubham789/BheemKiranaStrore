import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:groceryapp/controllers/get-user-data-controller.dart';
import 'package:groceryapp/controllers/sign-in-controller.dart';
import 'package:groceryapp/screens/admin-panel/admin-main-screen.dart';
import 'package:groceryapp/screens/auth-ui/forget-password-screen.dart';
import 'package:groceryapp/screens/auth-ui/sign-up-screen.dart';
import 'package:groceryapp/screens/user-panel/main-screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final SignInController signInController=Get.put(SignInController());
  final GetUserDataController getUserDataController=Get.put(GetUserDataController());
  TextEditingController userEmail=TextEditingController();
  TextEditingController userPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            title: Text('Sign In'),
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
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(()=>TextFormField(
                        controller: userPassword,
                        cursorColor: AppConstant.appMainColor,
                        obscureText: signInController.isPasswordVisible.value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                signInController.isPasswordVisible.toggle();
                              },
                                child:signInController.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                            contentPadding: EdgeInsets.only(top: 20.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                      ),
                    )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>ForgetPasswordScreen());
                      },
                      child: Text('Forgot Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                SizedBox(height:Get.height/12,),
                Material(
                  child: Container(
                    width: Get.width/2,
                    height: Get.height/15,
                    decoration: BoxDecoration(
                        color: AppConstant.appMainColor,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: TextButton(
                      child: Text('Sign In',style: TextStyle(color: AppConstant.appTextColor),),
                      onPressed: () async{
                        String email=userEmail.text.trim();
                        String password=userPassword.text.trim();
                        if(email.isEmpty || password.isEmpty){
                          Get.snackbar("Error", "please enter all details.");
                        }else{
                          UserCredential? userCredential=
                          await signInController.signInMethod(
                              email, password);

                          //ye code multideshboard handle karne ke liye hai user ki uid ko check krega
                          var userData=await getUserDataController.getUserData(userCredential!.user!.uid);
                          //agr user nhi equal hai null ke
                          if(UserCredential!=null){
                            if(userCredential!.user!.emailVerified){
                              //
                              if(userData[0]['isAdmin']==true){
                                Get.offAll(()=>AdminMainScreen());
                                Get.snackbar("Success Admin", "login successfully!",
                                    snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                    colorText: AppConstant.appTextColor);

                              }else{
                                Get.offAll(()=>MainScreens());
                                Get.snackbar("Successfully User Login!", " ",
                                    snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                    colorText: AppConstant.appTextColor);

                              }
                            }else{
                              Get.snackbar("Error", "Please verify your email before login.",
                                  snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                  colorText: AppConstant.appTextColor);
                            }
                          }else{
                            Get.snackbar("Error", "Please try again.",
                                snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                colorText: AppConstant.appTextColor);
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height/20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Get.offAll(()=>SignUpScreen());
                      },
                      child: Text("SignUp",
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  ],
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
