import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../modals/order-model.dart';
import '../../../../utils/app-constant.dart';

class CheckSingleOrderScreen extends StatefulWidget {
  String docId;
  OrderModel orderModel;
  CheckSingleOrderScreen({
    super.key, required this.docId,
    required this.orderModel});

  @override
  State<CheckSingleOrderScreen> createState() => _CheckSingleOrderScreenState();
}

class _CheckSingleOrderScreenState extends State<CheckSingleOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderModel.productName),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Product Name : "),
                  Text(widget.orderModel.productName)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Price : "),
                  Text(widget.orderModel.productTotalPrice.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Product Quantity : "),
                  Text(widget.orderModel.productQuantity.toString())
                ],
              ),

              Text("Product Description : "+widget.orderModel.productDescription.toString(),),

              Center(
                child: Container(
                  child: Image.network(widget.orderModel.productImages[0]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("CustomerName : "),
                  Text(widget.orderModel.customerName.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("CustomerPhone : "),
                  Text(widget.orderModel.customerPhone.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("CustomerAddress : "),
                  Text(widget.orderModel.customerAddress.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Lanmark : "),
                  Text(widget.orderModel.customerNearBy.toString())
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}