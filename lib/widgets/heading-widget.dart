import 'package:flutter/material.dart';
import 'package:groceryapp/utils/app-constant.dart';
class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;
  const HeadingWidget({super.key,
    required this.headingTitle,
    required this.headingSubTitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
      child: Padding(padding: EdgeInsets.all(8.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headingTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor)
                ,),
              Text(headingSubTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                    color: AppConstant.appTextColor)
                ,)
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppConstant.appMainColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: AppConstant.appMainColor,
                  width: 1.5,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(buttonText,style: TextStyle(fontSize: 12,fontFamily: 'impact'),),
              ),
            ),
          )
        ],
      ),),
    );
  }
}
