import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app-constant.dart';
import '../../controllers/categories-dropdown-controller.dart';
import '../../controllers/product-images-controller.dart';
import '../../widget/dropdowm-categories-widget.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? selectedValue;
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

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("categories").snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      return Center(
                        child: Text("Some error occured normally ${snapshot.error}"),
                      );
                    }
                    List<DropdownMenuItem> programItems=[];
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }else{
                      final selectProgram=snapshot.data?.docs.reversed.toList();
                      if(selectProgram!=null){
                        for(var program in selectProgram){
                          programItems.add(
                              DropdownMenuItem(
                                  value: program.id,
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(program['categoryImg'].toString()),
                                      ),
                                      SizedBox(width: 20.0,),
                                      Text(program['categoryName']),
                                    ],
                                  )
                              )
                          );
                        }
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButton(
                          value: selectedValue,
                          items: programItems,
                          onChanged: (value){
                            setState(() {
                              selectedValue=value;
                            });
                            Get.snackbar("Click Id Category", selectedValue.toString());
                          },
                          hint:  Text("Select Category"),
                          isExpanded: true,
                          elevation: 10,
                          underline: SizedBox.shrink(),),
                      ),
                    );

                  }),
            ],
          ),
        ),
      ),
    );
  }
}