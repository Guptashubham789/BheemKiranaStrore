import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/product-model.dart';
import 'package:image_card/image_card.dart';
class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('product').where('isSale',isEqualTo: true).get(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text('FlashSale is empty'),
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
            return Container(
              height: Get.height/5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){

                    final productData=snapshot.data!.docs[index];

                    ProductModel productModel=ProductModel(
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
                    );

                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width/3.2,
                              heightImage: Get.height/12,
                              imageProvider: CachedNetworkImageProvider(productModel.productImages[0]),
                              title: Center(child: Text(productModel.productName,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),)),
                              footer: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Rs ${productModel.salePrice}",style: TextStyle(fontSize: 10),),
                                    Text(" ${productModel.fullPrice}",style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough,color: Colors.black),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
              ),
            );
          }
          return Container();
        }
    );
  }
}
