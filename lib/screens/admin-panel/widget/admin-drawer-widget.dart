import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/screens/admin-panel/view/orders/all-user-orders-screen.dart';
import 'package:groceryapp/screens/admin-panel/view/product/all-product-screen.dart';

import '../../../utils/app-constant.dart';
import '../../user-panel/all-orders-screen.dart';
import '../view/all-users-screen.dart';



class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({super.key});

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {

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
                title: Text("SGTech"),
                leading: CircleAvatar(
                  child: Text("G",style: TextStyle(color: AppConstant.appMainColor),),
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
                onTap: (){
                  Get.to(()=>AllUsersScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Users"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>AllUserOrdersScreen());
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
                onTap: (){
                  Get.to(()=>AllProductScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Product"),
                leading: Icon(Icons.production_quantity_limits),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Categories"),
                leading: Icon(Icons.category),
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
                onTap: () {

                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Reviews"),
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