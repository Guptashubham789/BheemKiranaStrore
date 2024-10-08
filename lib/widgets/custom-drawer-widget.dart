import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/utils/app-constant.dart';

import '../screens/auth-ui/welcome-screen.dart';
import '../screens/user-panel/all-orders-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: Get.height/25),
    child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0))
        ),
      child: Wrap(
        runSpacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(user!.displayName.toString()),

              leading: CircleAvatar(
                radius: 20,
                backgroundColor: AppConstant.appMainColor,
                backgroundImage: NetworkImage(user!.photoURL.toString()),
              ),
            ),
          ),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 1.5,
            color: AppConstant.appTextColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Home"),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Product"),
              leading: Icon(Icons.production_quantity_limits),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: (){
                Get.to(()=>AllOrdersScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Orders"),
              leading: Icon(Icons.shopping_bag),
              trailing: Icon(Icons.arrow_forward),

            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(

              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Contact"),
              leading: Icon(Icons.help),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: () async{
                GoogleSignIn googleSignIn=GoogleSignIn();
                FirebaseAuth _auth=FirebaseAuth.instance;
                await _auth.signOut();
                await googleSignIn.signOut();
                Get.offAll(()=>WelcomeScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
      backgroundColor: AppConstant.appMainColor,
    ),
    );
  }
}
