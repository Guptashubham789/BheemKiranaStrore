import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/screens/user-panel/single-category-product-screen.dart';
import 'package:groceryapp/screens/user-panel/single-product-details-screen.dart';
import 'package:image_card/image_card.dart';

import '../../modals/categories-model.dart';
import '../../modals/product-model.dart';
import '../../utils/app-constant.dart';
class AllFlashSaleProductScreen extends StatefulWidget {
  const AllFlashSaleProductScreen({super.key});

  @override
  State<AllFlashSaleProductScreen> createState() => _AllFlashSaleProductScreenState();
}

class _AllFlashSaleProductScreenState extends State<AllFlashSaleProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Flash Sale'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('product').where('isSale',isEqualTo: true).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Categories is empty'),
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
                child: Text('No Category found!!'),
              );
            }
            if(snapshot.data!=null){
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1.19

                  ),
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
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>SingleProductScreen(productModel: productModel,));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20.0,
                                width: Get.width/2.3,
                                heightImage: Get.height/10,
                                imageProvider: CachedNetworkImageProvider(productModel.productImages[0]),
                                title: Center(child: Text(productModel.productName,style: TextStyle(fontSize: 12.0),)),

                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }

              );
            }
            return Container();
          }
      ),
    );
  }
}
