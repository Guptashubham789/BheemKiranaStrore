import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:groceryapp/controllers/get-device-token-controller.dart';
import 'package:groceryapp/modals/UserModel.dart';
import 'package:groceryapp/utils/app-constant.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //for password visibilty
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
      String userName,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,
      ) async{
    final GetDeviceTokenController getDeviceTokenController=Get.put(GetDeviceTokenController());
      try{
        EasyLoading.show(status: "Please wait..");
        UserCredential userCredential=await _auth.createUserWithEmailAndPassword(
            email: userEmail.toString(),
            password: userPassword.toString(),
        );
        //user jb hmara signup ho to usko ek email send karo verification ke liye

        await userCredential.user!.sendEmailVerification();

        Usermodel usermodel=Usermodel(
            uId: userCredential.user!.uid,
            username: userName,
            email: userEmail,
            phone: userPhone,
            userImg: '',
            userDeviceToken: getDeviceTokenController.deviceToken.toString(),
            country: '',
            userAddress: '',
            street: '',
            userCity: userCity,
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
        );
        
        //ab hme firebase ke andr data send karna h
        _firestore.collection('users').doc(userCredential.user!.uid).set(usermodel.toMap());
        EasyLoading.dismiss();
        return userCredential;



      } on FirebaseAuthException catch(e){
        EasyLoading.dismiss();
        Get.snackbar("Error", "$e",
            snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
        colorText: AppConstant.appTextColor);
      }
  }
}