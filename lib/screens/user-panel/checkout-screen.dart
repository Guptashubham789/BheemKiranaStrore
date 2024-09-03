import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/controllers/get-customer-device-token.dart';
import 'package:groceryapp/modals/cart-model.dart';
import 'package:groceryapp/utils/app-constant.dart';

import '../../controllers/cart-price-controller.dart';
import '../../services/place-order-service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController=Get.put(ProductPriceController());
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController nearByController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Conform Order'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('CartOrders').snapshots(),
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

                      CartModel cartModel=CartModel(
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
                      );

                      //calculate price
                      productPriceController.fetchProductPrice();
                      return SwipeActionCell(
                        key: ObjectKey(cartModel.productId),
                        trailingActions: [
                          SwipeAction(
                              backgroundRadius: 10.0,
                              title: "Delete",
                              forceAlignmentToBoundary: true,
                              performsFirstActionWithFullSwipe: true,
                              onTap: (CompletionHandler handler) async{
                                print('delete');
                                await FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(user!.uid)
                                    .collection('CartOrders')
                                    .doc(cartModel.productId)
                                    .delete();
                              })
                        ],
                        child: Card(
                          elevation: 5,

                          child: ListTile(
                            title: Text(cartModel.productName),
                            leading: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              backgroundImage: NetworkImage(cartModel.productImages[0]),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(cartModel.productTotalPrice.toString()),
                                SizedBox(
                                  width: Get.width/20.0,
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            return Container();
          }
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(()=>Text("Total : ${productPriceController.totalPrice.value.toStringAsFixed(1)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: AppConstant.appFontFamily),),),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Material(
                child: Container(
                  width: Get.width/2.3,
                  height: Get.height/16,
                  decoration: BoxDecoration(
                      color: AppConstant.appMainColor,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: TextButton(
                    child: Text('Conform Order',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily,fontWeight: FontWeight.bold,fontSize: 13),),
                    onPressed: () async{
                           showCustomBottomSheet();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

void showCustomBottomSheet() {
  Get.bottomSheet(
    Container(
      height: Get.height * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller:nameController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppConstant.appMainColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Name ',
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.only(top: 20.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                )
            ),
            SizedBox(height: Get.height / 80,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                     controller: phoneController,
                    cursorColor: AppConstant.appMainColor,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.only(top: 20.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                )),
            SizedBox(height: Get.height / 80,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                     controller: nearByController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppConstant.appMainColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Near By ',
                        prefixIcon: Icon(Icons.pin_drop),
                        contentPadding: EdgeInsets.only(top: 20.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                  ),
                )),
            SizedBox(height: Get.height / 80,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLines: 2,
                    textInputAction: TextInputAction.next,
                    controller: addressController,
                    cursorColor: AppConstant.appMainColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Full Address',
                      prefixIcon: Icon(Icons.pin_drop),
                      contentPadding: EdgeInsets.only(top: 20.0, left: 8.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black)
                      ),

                    ),
                  ),
                )
            ),
            SizedBox(height: Get.height / 40,),
            Material(
              child: Container(
                width: Get.width / 1.3,
                height: Get.height / 12,
                decoration: BoxDecoration(
                    color: AppConstant.appMainColor,
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: TextButton(
                  child: Text('Place Orders',
                    style: TextStyle(color: AppConstant.appTextColor),),
                  onPressed: () async{
                    if(nameController.text!='' && phoneController.text!='' && nearByController.text!='' && addressController.text!=''){
                      String name=nameController.text.trim();
                      String phone=phoneController.text.trim();
                      String nearBy=nearByController.text.trim();
                      String address=addressController.text.trim();

                      String customerToken=await getCustomerDeviceToken();


                      //place order services
                      placeOrder(
                        context:context,
                        customerName:name,
                        customerPhone:phone,
                        customerNerBy:nearBy,
                        customerAddress:address,
                        customerDeviceToken:customerToken,
                      );

                    }else{
                      Get.snackbar("Please", "please fill the all fields..",
                        snackPosition: SnackPosition.TOP,backgroundColor: AppConstant.appMainColor,
                        colorText: AppConstant.appTextColor,
                        duration: Duration(seconds: 5),
                      );
                    }
                  },
                ),
              ),
            )

          ],
        ),
      ),

    ),
    backgroundColor: Colors.white70,
    isDismissible: true,
    enableDrag: true,
    elevation: 6,
  );
}
}
