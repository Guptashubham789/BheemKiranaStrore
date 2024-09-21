import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app-constant.dart';
import '../../controllers/categories-dropdown-controller.dart';
import '../../controllers/product-images-controller.dart';
import '../../widget/dropdowm-categories-widget.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  AddProductImagesController addProductImagesController=Get.put(AddProductImagesController());
  CategoriesDropDownController categoryDropDownController=Get.put(CategoriesDropDownController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Images'),
                  ElevatedButton(
                      onPressed: (){
                        addProductImagesController.showImagesPickerDialog();
                      },
                      child: Text('Select Images')
                  ),
                ],
              ),
              //show images
              GetBuilder<AddProductImagesController>(
                  init: AddProductImagesController(),
                  builder: (addProductImagesController){
                    return addProductImagesController.selectedImages.length>0
                        ?Container(
                      width: Get.width-20,
                      height: Get.height/3.0,
                      child: GridView.builder(
                        itemCount: addProductImagesController.selectedImages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context,int index){
                          return Stack(
                            children: [
                              Image.file(
                                File(addProductImagesController.selectedImages[index].path),
                                fit: BoxFit.cover,
                                height: Get.height/4,
                                width: Get.width/2,
                              ),
                              Positioned(child: InkWell(
                                onTap: (){
                                  addProductImagesController.removeImage(index);
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppConstant.appMainColor,
                                  child: Icon(Icons.close,color: AppConstant.appTextColor,),
                                ),
                              ))
                            ],
                          );
                        },
                      ),
                    ):SizedBox.shrink();
                  }),

                DropDownCategoriesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}