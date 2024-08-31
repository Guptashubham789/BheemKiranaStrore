import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/controllers/get-device-token-controller.dart';
import 'package:groceryapp/modals/UserModel.dart';
import 'package:groceryapp/screens/user-panel/main-screen.dart';

class GoogleSignInController extends GetxController{
  //jo maine package import kiya hai uska instance bnaa lenge
  final GoogleSignIn googleSignIn=GoogleSignIn();
  final FirebaseAuth _auth=FirebaseAuth.instance;


  Future<void> signInWithGoogle() async{
    final GetDeviceTokenController _getDeviceTokenController=Get.put(GetDeviceTokenController());
    try{
      final GoogleSignInAccount? googleSignInAccount=
        await googleSignIn.signIn();
      //yani ki jab acc apna select and click karwayenge to tb mai dekhna chah rha hu ki
      //hmara acc empty to nhi hai
      if(googleSignInAccount!=null){
        EasyLoading.show(status: "Please wait..");
        final GoogleSignInAuthentication googleSignInAuthentication=
            await googleSignInAccount.authentication;
        //jb user login kar rha hoga to uski creadential le lenge
        //creadential method ke andr 2 chije req hoti h id token
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken:googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        //ab hme dekhna h user credential ki kya yah khali to nhi hai
        final UserCredential userCredential=
          await _auth.signInWithCredential(credential);

        //jo bhi user yha se login ho rha hoga to uski detaild usercredential me save ho jaayegi
          final User? user=userCredential.user;

          //ab hmara user yha tk aa jaye to hme condition lgana hoga

        if(user != null){
            Usermodel usermodel=Usermodel(
                uId: user.uid,
                username: user.displayName.toString(),
                email: user.email.toString(),
                phone: user.phoneNumber.toString(),
                userImg: user.photoURL.toString(),
                userDeviceToken: _getDeviceTokenController.deviceToken.toString(),
                country: '',
                userAddress: '',
                street: '',
                userCity: '',
                isAdmin: false,
                isActive: true,
                createdOn: DateTime.now(),
            );
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set(usermodel.toMap());
            EasyLoading.dismiss();
            Get.offAll(()=> const MainScreens());
        }
      }
    }catch(e){
      EasyLoading.dismiss();
      print("Error : $e");
    }
  }

}