import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/product-model.dart';
import 'package:groceryapp/screens/user-panel/single-product-details-screen.dart';
import 'package:groceryapp/utils/app-constant.dart';
import 'package:image_card/image_card.dart';
class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("All Product"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('product').where('isSale',isEqualTo: false).snapshots(),
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
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.80

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
                            Get.to(()=>SingleProductScreen(productModel:productModel));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20.0,
                                width: Get.width/2.3,
                                heightImage: Get.height/6,
                                imageProvider: CachedNetworkImageProvider(productModel.productImages[0]),
                                title: Center(child: Text(productModel.productName,style: TextStyle(fontSize: 12.0),)),
                                footer: Center(child: Text("Price : "+productModel.fullPrice+" -/")),
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
