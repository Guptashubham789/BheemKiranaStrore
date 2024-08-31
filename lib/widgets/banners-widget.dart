import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/controllers/banners-controller.dart';
class BannerWidge extends StatefulWidget {
  const BannerWidge({super.key});

  @override
  State<BannerWidge> createState() => _BannerWidgeState();
}

class _BannerWidgeState extends State<BannerWidge> {
  final CarouselController carouselController=CarouselController();
  final bannersController _controller=Get.put(bannersController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx((){
        return CarouselSlider(
          items: _controller.bannerUrls.map((imageUrls)=>ClipRRect(
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
      );
      }),
    );
  }
}
