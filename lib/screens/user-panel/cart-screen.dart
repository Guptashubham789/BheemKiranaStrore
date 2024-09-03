import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/cart-model.dart';
import 'package:groceryapp/screens/user-panel/checkout-screen.dart';
import 'package:groceryapp/utils/app-constant.dart';

import '../../controllers/cart-price-controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController=Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Cart Screen'),
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
                             GestureDetector(
                               onTap: () async{

                                 if(cartModel.productQuantity>1){
                                   await FirebaseFirestore.instance
                                       .collection('cart')
                                       .doc(user!.uid)
                                       .collection('CartOrders')
                                       .doc(cartModel.productId)
                                       .update({
                                              'productQuantity':cartModel.productQuantity-1,
                                              'productTotalPrice':
                                              (double.parse(cartModel.fullPrice)*
                                                  (cartModel.productQuantity-1)),
                                        });
                                 }
                                 print('Hello');
                               },
                               child: CircleAvatar(
                                 backgroundColor: AppConstant.appMainColor,
                                 radius: 14.0,
                                 child: Text('-'),
                               ),
                             ),
                             SizedBox(
                               width: Get.width/20.0,
                             ),
                             Text(cartModel.productQuantity.toString()),
                             SizedBox(
                               width: Get.width/20.0,
                             ),
                             GestureDetector(
                               onTap: () async{
                                 if(cartModel.productQuantity>0){
                                   await FirebaseFirestore.instance
                                       .collection('cart')
                                       .doc(user!.uid)
                                       .collection('CartOrders')
                                       .doc(cartModel.productId)
                                       .update({
                                     'productQuantity':cartModel.productQuantity+1,
                                     'productTotalPrice':
                                     double.parse(cartModel.fullPrice)+
                                        double.parse(cartModel.fullPrice)*
                                         (cartModel.productQuantity),
                                   });
                                 }
                               },
                               child: CircleAvatar(
                                 backgroundColor: AppConstant.appMainColor,
                                 radius: 14.0,
                                 child: Text('+'),
                               ),
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
              padding: const EdgeInsets.only(right: 30.0),
              child: Material(
                child: Container(
                  width: Get.width/3.0,
                  height: Get.height/18,
                  decoration: BoxDecoration(
                      color: AppConstant.appMainColor,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: TextButton(
                    child: Text('Checkout',style: TextStyle(color: AppConstant.appTextColor),),
                    onPressed: (){
                     Get.to(()=> CheckoutScreen());
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
}
