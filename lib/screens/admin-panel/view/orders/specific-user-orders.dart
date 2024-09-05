import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../modals/order-model.dart';
import '../../../../utils/app-constant.dart';
import 'check-single-order-screen.dart';

class SpecificUserOrdersScreen extends StatefulWidget {
  String customerName;
  String docId;
  SpecificUserOrdersScreen({
    super.key, required this.customerName, required this.docId});

  @override
  State<SpecificUserOrdersScreen> createState() => _SpecificUserOrdersScreenState();
}

class _SpecificUserOrdersScreenState extends State<SpecificUserOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(widget.docId)
              .collection('ConfirmOrders')
              .snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Error occured while fetching category!!'),
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
                child: Text('No order found!!'),
              );
            }
            if(snapshot.data!=null){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    final data=snapshot.data!.docs[index];
                    OrderModel orderModel=OrderModel(
                      productId: data['productId'],
                      categoryId: data['categoryId'],
                      productName: data['productName'],
                      categoryName: data['categoryName'],
                      salePrice: data['salePrice'],
                      fullPrice: data['fullPrice'],
                      productImages: data['productImages'],
                      deliveryTime: data['deliveryTime'],
                      isSale: data['isSale'],
                      productDescription: data['productDescription'],
                      createdAt:DateTime.now(),
                      updatedAt: data['updatedAt'],
                      productQuantity: data['productQuantity'],
                      productTotalPrice: data['productTotalPrice'],
                      customerId: data['customerId'],
                      status: false, //starting me false send karenge
                      customerName: data['customerName'],
                      customerPhone: data['customerPhone'],
                      customerNearBy: data['customerNearBy'],
                      customerAddress: data['customerAddress'],
                      customerDeviceToken: data['customerDeviceToken'],
                    );
                    return Card(
                      elevation: 5,

                      child: ListTile(
                        onTap: (){
                          Get.to(()=>CheckSingleOrderScreen(
                            docId:snapshot.data!.docs[index].id,
                            orderModel:orderModel,
                          ));
                        },
                        title: Text(orderModel.productName),
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage: NetworkImage(orderModel.productImages[0]),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(orderModel.productQuantity.toString(),style: TextStyle(color: Colors.black,fontSize: 10.0),),
                            SizedBox(
                              width: Get.width/20.0,
                            ),

                          ],
                        ),
                        trailing: Icon(Icons.edit),
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