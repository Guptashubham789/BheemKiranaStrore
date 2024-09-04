import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/cart-model.dart';
import 'package:groceryapp/modals/order-model.dart';
import 'package:groceryapp/screens/user-panel/checkout-screen.dart';
import 'package:groceryapp/utils/app-constant.dart';

import '../../controllers/cart-price-controller.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController=Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('All Orders'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(user!.uid)
              .collection('ConfirmOrders')
              .snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('All product is empty'),
              );
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(
                height: Get.height/5,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }

            //jo data fetch kar rhe hai kya vh empty to nhi hai agr empty h to center me
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text('No products found!!'),
              );
            }
            if(snapshot.data!=null){

              return  Container(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      final productData=snapshot.data!.docs[index];

                      OrderModel orderModel=OrderModel(
                        productId: productData['productId'],
                        categoryId: productData['categoryId'],
                        productName: productData['productName'],
                        categoryName: productData['categoryName'],
                        salePrice: productData['salePrice'],
                        fullPrice: productData['fullPrice'],
                        productImages: productData['productImages'],
                        deliveryTime: productData['deliveryTime'],
                        isSale: productData['isSale'],
                        productDescription: productData['productDescription'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt'],
                        productQuantity: productData['productQuantity'],
                        productTotalPrice: productData['productTotalPrice'],
                        customerId: productData['customerId'],
                        status: productData['status'],
                        customerName: productData['customerName'],
                        customerPhone: productData['customerPhone'],
                        customerNearBy: productData['customerNearBy'],
                        customerAddress: productData['customerAddress'],
                        customerDeviceToken: productData['customerDeviceToken'],
                      );

                      //calculate price
                      productPriceController.fetchProductPrice();
                      return Card(
                        elevation: 5,

                        child: ListTile(
                          title: Text(orderModel.productName),
                          leading: CircleAvatar(
                            backgroundColor: AppConstant.appMainColor,
                            backgroundImage: NetworkImage(orderModel.productImages[0]),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(orderModel.productTotalPrice.toString()),
                              
                              SizedBox(
                                width: Get.width/5.0,
                              ),
                              Container(
                                height: Get.height/22,
                                color: AppConstant.appMainColor,

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SizedBox(
                                      child: orderModel.status!=true?Text("Pending 😀",style: TextStyle(fontFamily: AppConstant.appFontFamily,color: Colors.red),):Text("Deleverd 🥰" ,style: TextStyle(fontFamily: AppConstant.appFontFamily,color: Colors.green),),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width/70.0,
                              ),
                              orderModel.status!=true?Text(' '):GestureDetector(
                                onTap: (){},
                                child: Icon(Icons.delete),
                              ),




                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
            return Container();
          }
      ),

    );
  }
}
