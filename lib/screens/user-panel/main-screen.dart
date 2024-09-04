import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/screens/auth-ui/welcome-screen.dart';
import 'package:groceryapp/screens/user-panel/all-categories-screen.dart';
import 'package:groceryapp/screens/user-panel/all-flash-sale-product.dart';
import 'package:groceryapp/screens/user-panel/cart-screen.dart';
import 'package:groceryapp/screens/user-panel/user-profile.dart';
import 'package:groceryapp/widgets/banners-widget.dart';
import 'package:groceryapp/widgets/category-widget.dart';
import 'package:groceryapp/widgets/custom-drawer-widget.dart';
import 'package:groceryapp/widgets/flash-sale-widget.dart';
import 'package:groceryapp/widgets/heading-widget.dart';

import '../../utils/app-constant.dart';
import '../../widgets/all-product-widget.dart';
import 'all-product-screen.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.appName),
        backgroundColor:AppConstant.appMainColor,
        actions: [


          GestureDetector(
            onTap: (){
              Get.to(()=>CartScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>UserProfile());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.account_circle_rounded),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/90.0,),

              //banners
              BannerWidge(),
              //heading
              HeadingWidget(
                headingSubTitle: "All categories",
                headingTitle: "Categories",
                onTap: (){
                  Get.to(()=>AllCategoriesScreen());
                },
                buttonText: "See More",
              ),
              //categories
              CategoryWidget(),

              HeadingWidget(
                headingSubTitle: "According to your budget!",
                headingTitle: "Flash Sale",
                onTap: (){
                  Get.to(()=>AllFlashSaleProductScreen());
                },
                buttonText: "See More",
              ),
              //flash Sale widget
              FlashSaleWidget(),
              HeadingWidget(
                headingSubTitle: "According to your budget!",
                headingTitle: "All Product",
                onTap: (){
                  Get.to(()=>AllProductScreen());
                },
                buttonText: "See More",
              ),
              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
