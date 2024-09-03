
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:groceryapp/modals/order-model.dart';
import 'package:groceryapp/screens/user-panel/main-screen.dart';

import '../utils/app-constant.dart';
import 'genrate-order-id-service.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerNerBy,
  required String customerAddress,
  required String customerDeviceToken
  }) async{

  final user=FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please wait!!");
  if(user!=null){
    try{

      //jo bhi user h uske cartOrder me pure cart item ko fetch kar liya hai
      //
      QuerySnapshot querySnapshot=await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('CartOrders').get();
      //jitne bhi docs honge es list ke andr show karwa lenge
      List<QueryDocumentSnapshot> documents=querySnapshot.docs;
      for(var doc in documents){
        Map<String,dynamic>? data=doc.data() as Map<String,dynamic>;

        String orderId=genrateOrderId();

        OrderModel orderModel=OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt:DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: data['productTotalPrice'],
          customerId: user.uid,
          status: false, //starting me false send karenge
          customerName: customerName,
          customerPhone: customerPhone,
          customerNearBy: customerNerBy,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );
        for(var x=0; x<documents.length;x++){
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
                'uId':user.uid,
                'customerName':customerName,
                'customerPhone':customerPhone,
                'customerAddress':customerAddress,
                'customerDeviceToken':customerDeviceToken,
                'orderStatus':false,
                'createdAt':DateTime.now()
              },
          );
          //upload Orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('ConfirmOrders')
              .doc(orderId)
              .set(orderModel.toMap());
          
          //delete cart product
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('CartOrders')
              .doc(orderModel.productId.toString())
              .delete().then((value){
                print("Delete cart product");
          });
        }
      }
      print("Order Confirmed");
      Get.snackbar("Order Confirmed", "Thank You For Order!!",
          snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor,
        duration: Duration(seconds: 5),
      );
      EasyLoading.dismiss();
      Get.offAll(()=>MainScreens());
    }catch(e){
      print("Error: $e");
    }
  }

}