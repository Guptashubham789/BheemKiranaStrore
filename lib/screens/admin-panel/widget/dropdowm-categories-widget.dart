import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categories-dropdown-controller.dart';

class DropDownCategoriesWidget extends StatelessWidget {
  const DropDownCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesDropDownController>(
      init: CategoriesDropDownController(),
        builder: (categoryDropDownController){
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                        items: categoryDropDownController.categories
                            .map((element){
                            return DropdownMenuItem<String>(
                                value: categoryDropDownController.selectedCategoryId?.value,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(element['categoryImg'].toString()),
                                    ),
                                    SizedBox(width: 20.0,),
                                    Text(element['categoryName']),
                                  ],
                                )
                            );
                        }).toList(),
                        onChanged: (String? selectedData) async{
                          
                        },
                      hint:  Text("Select Category"),
                      isExpanded: true,
                      elevation: 10,
                      underline: SizedBox.shrink(),
                    ),
                  ),
                ),
              )
            ],
          );
        },
    );
  }
}
