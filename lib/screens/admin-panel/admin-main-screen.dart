import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/screens/admin-panel/widget/admin-drawer-widget.dart';
import 'package:groceryapp/screens/auth-ui/welcome-screen.dart';
import 'package:groceryapp/utils/app-constant.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen"),
        backgroundColor: AppConstant.appMainColor,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>WelcomeScreen());
          }, icon: Icon(Icons.logout))
        ],
      ),
      drawer: AdminDrawerWidget(),
    );
  }
}
