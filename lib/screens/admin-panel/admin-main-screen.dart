import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/screens/admin-panel/widget/admin-drawer-widget.dart';
import 'package:groceryapp/screens/admin-panel/widget/dropdowm-categories-widget.dart';
import 'package:groceryapp/screens/auth-ui/welcome-screen.dart';
import 'package:groceryapp/utils/app-constant.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen"),
        backgroundColor: AppConstant.appMainColor,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>WelcomeScreen());
          }, icon: Icon(Icons.logout))
        ],
      ),
      drawer: AdminDrawerWidget(),
      body: Column(
        children: [
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

    );
  }
}
