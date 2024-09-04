import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/cart-model.dart';
import 'package:groceryapp/modals/product-model.dart';
import 'package:groceryapp/utils/app-constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/banners-controller.dart';
import 'cart-screen.dart';
class SingleProductScreen extends StatefulWidget {
  ProductModel productModel;
   SingleProductScreen({super.key, required this.productModel});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final CarouselController carouselController=CarouselController();

  User? user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(widget.productModel.productName),
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
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
            child: CarouselSlider(
              items: widget.productModel.productImages.
              map((imageUrls)=>ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(imageUrl: imageUrls,fit: BoxFit.cover,width: Get.width-10,
                  placeholder: (context,url)=>ColoredBox(color: Colors.white,child: Center(child: CupertinoActivityIndicator(),),),
                  errorWidget: (context,url,error)=>Icon(Icons.error),
                ),
              ),).toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.0,
                viewportFraction: 1,
              ),
            ),
            ),
            Padding(padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.productModel.productName),
                            Icon(Icons.favorite_border_outlined)
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text("Category : "+widget.productModel.categoryName)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale==true && widget.productModel.salePrice!=''?
                            Text("Price : "+widget.productModel.salePrice):Text("Price : "+widget.productModel.fullPrice),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text("Delivery : "+widget.productModel.deliveryTime)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text("Description : "+widget.productModel.productDescription)),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          child: Container(
                            width: Get.width/2.5,
                            height: Get.height/16,
                            decoration: BoxDecoration(
                                color: AppConstant.appMainColor,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: TextButton(
                              child: Text('Add to cart',style: TextStyle(color: AppConstant.appTextColor),),
                              onPressed: () async{
                                //Get.to(()=> SignScreen());
                               await checkProductExistence(uId:user!.uid);
                              },
                            ),
                          ),
                        ),
                        Material(
                          child: Container(
                            width: Get.width/2.5,
                            height: Get.height/16,
                            decoration: BoxDecoration(
                                color: AppConstant.appMainColor,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: TextButton(
                              child: Text('Whatsapp',style: TextStyle(color: AppConstant.appTextColor),),
                              onPressed: (){
                                sendMessageOnWhatsapp(
                                  productModel:widget.productModel,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
  static Future<void> sendMessageOnWhatsapp({
    required ProductModel productModel
  }) async{
    final number="+916393539704";
    final message="Hello SGTech \n Grocery App \n i want to about this product \n${productModel.productName} \n ${productModel.productId}";
    final url='https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if(await canLaunchUrl(url as Uri)){
      await launchUrl(url as Uri);
    }else{
      throw 'Could not launch $url';
    }
  }
  //check product exist or not

  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement=1,
  }) async{
    //hme hr bande ko usi ke cart ke product dikhane mtlb ki uska  ek document bnayenge
    //alg alg user ka alg alg documnet hoga and eska collection
    final DocumentReference documentReference=
     FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('CartOrders')
        .doc(widget.productModel.productId.toString());

    //snapshot ke ander hmne document ko get kar lena hai
    DocumentSnapshot snapshot=await documentReference.get();

    //agr hmara product add ho jayega cart screen me to hum bs uske quantity ko update karenge
    if(snapshot.exists){
      int currentQuantity=snapshot['productQuantity'];
      int updateQuantity=currentQuantity + quantityIncrement;
      double totalPrice=
          double.parse(widget.productModel.isSale? widget.productModel.salePrice:widget.productModel.fullPrice)*updateQuantity;

      await documentReference.update({
        'productQuantity':updateQuantity,
        'productTotalPrice':totalPrice,
      });
      Get.snackbar("Product", "Product already add in cart screen!",
          snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor
      );
      
    }else{
      //jb hmara product exist nhi karta cart me tb use hme database me send karne ke liye
      //this is a subcollaction
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
          'uId':uId,
        'createdAt':DateTime.now(),
      });
      //yeh cart collaction ke andr ek aur collaction bnayega order

      CartModel cartModel=CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.isSale? widget.productModel.salePrice:widget.productModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());
      Get.snackbar("Product", "Product added in cart screen!!",
          snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appTextColor
      );

    }

  }
}
