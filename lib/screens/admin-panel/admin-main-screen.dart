import 'package:flutter/material.dart';
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
      ),
    );
  }
}
