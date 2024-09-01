import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/modals/product-model.dart';
import 'package:groceryapp/utils/app-constant.dart';

import '../../controllers/banners-controller.dart';
class SingleProductScreen extends StatefulWidget {
  ProductModel productModel;
   SingleProductScreen({super.key, required this.productModel});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  final CarouselController carouselController=CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(widget.productModel.productName),
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
                        child: Text("Price : "+widget.productModel.fullPrice)),
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
                              onPressed: (){
                                //Get.to(()=> SignScreen());
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
                                //Get.to(()=> SignScreen());
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
}
