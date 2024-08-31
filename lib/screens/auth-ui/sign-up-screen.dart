import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:groceryapp/controllers/sign-up-controller.dart';
import 'package:groceryapp/screens/auth-ui/sign-in-screen.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController=Get.put(SignUpController());
  TextEditingController username=TextEditingController();
  TextEditingController useremail=TextEditingController();
  TextEditingController userpassword=TextEditingController();
  TextEditingController userphone=TextEditingController();
  TextEditingController usercity=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            title: Text('Sign Up',
              style: TextStyle(fontFamily: AppConstant.appFontFamily),
            ),
            centerTitle: true,

            backgroundColor: AppConstant.appMainColor,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
            
            
                  Container(
                    alignment: Alignment.center,
                      child: Text('Welcome To My App')),
                  SizedBox(height: Get.height/60,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: username,
                          cursorColor: AppConstant.appMainColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Icon(Icons.person),
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
                        child: TextFormField(
                          controller: useremail,
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
                        child: Obx(()=>
                            TextFormField(
                              controller: userpassword,
                              obscureText: signUpController.isPasswordVisible.value,
                              cursorColor: AppConstant.appMainColor,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: GestureDetector(
                                      onTap: (){
                                        signUpController.isPasswordVisible.toggle();
                                      },
                                      child:signUpController.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility),),
                                  contentPadding: EdgeInsets.only(top: 20.0,left: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )
                              ),
                            ),
                        ),
                      )),
                  SizedBox(height: Get.height/60,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: userphone,
                          cursorColor: AppConstant.appMainColor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
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
                        child: TextFormField(
                          controller: usercity,
                          cursorColor: AppConstant.appMainColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'City',
                              prefixIcon: Icon(Icons.pin_drop),
                              contentPadding: EdgeInsets.only(top: 20.0,left: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ),
                      )),
            
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
                        child: Text('Sign Up',style: TextStyle(color: AppConstant.appTextColor),),
                        onPressed: () async{
                          String name=username.text.trim();
                          String email=useremail.text.trim();
                          String password=userpassword.text.trim();
                          String phone=userphone.text.trim();
                          String city=usercity.text.trim();
                          String UserDeviceToken='';
                          if(name.isEmpty || email.isEmpty || password.isEmpty ||
                          phone.isEmpty || city.isEmpty){
                            Get.snackbar("Error", "Please enter all details",
                                snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                colorText: AppConstant.appTextColor
                            );
                          }else{
                            UserCredential? userCredential=await signUpController.signUpMethod(
                                name,
                                email,
                                phone,
                                city,
                                password,
                                UserDeviceToken,
                            );

                            if(userCredential!= null){
                              Get.snackbar("Verification email sent.", "Please check your email.",
                                  snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                                  colorText: AppConstant.appTextColor
                              );
                            }
                            FirebaseAuth.instance.signOut();
                            Get.offAll(()=>SignScreen());
                          }

                        },
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height/20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                        ),),
                      GestureDetector(
                        onTap: (){
                          Get.offAll(()=>SignScreen());
                        },
                        child: Text("Login",
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
          ),
        );
      },
    );
  }
}
