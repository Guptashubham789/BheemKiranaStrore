import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/screens/admin-panel/view/orders/specific-user-orders.dart';

import '../../../../utils/app-constant.dart';

class AllUserOrdersScreen extends StatefulWidget {
  const AllUserOrdersScreen({super.key});

  @override
  State<AllUserOrdersScreen> createState() => _AllUserOrdersScreenState();
}

class _AllUserOrdersScreenState extends State<AllUserOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Orders"),
        backgroundColor: AppConstant.appMainColor,
      ),
      body:  StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .orderBy('createdAt',descending: true)
              .snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Error occured while fetching orders!!'),
              );
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(
                height: Get.height/5,
                child: Center(
                  child:CupertinoActivityIndicator(),
                ),
              );
            }

            //jo data fetch kar rhe hai kya vh empty to nhi hai agr empty h to center me
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text('No orders found!!'),
              );
            }
            if(snapshot.data!=null){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    final data=snapshot.data!.docs[index];

                    return Card(
                      elevation: 5,

                      child: ListTile(
                        onTap: (){
                          Get.to(()=>SpecificUserOrdersScreen(
                              docId:snapshot.data!.docs[index]['uId'],
                              customerName:snapshot.data!.docs[index]['customerName']
                          ));
                        },
                        title: Text(data['customerName']),
                        leading: CircleAvatar(
                          child: Text(data['customerName'][0]),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data['customerPhone'],style: TextStyle(color: Colors.black,fontSize: 10.0),),
                            SizedBox(
                              width: Get.width/20.0,
                            ),

                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward),
                      ),
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