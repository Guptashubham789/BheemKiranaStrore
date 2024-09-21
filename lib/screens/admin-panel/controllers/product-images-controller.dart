import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductImagesController extends GetxController{
  final ImagePicker _picker=ImagePicker();
  RxList<XFile> selectedImages =<XFile>[].obs;

  final RxList<String> arrImagesUrl= <String>[].obs;
  final FirebaseStorage storageRef=FirebaseStorage.instance;
  Future<void> showImagesPickerDialog() async{
    PermissionStatus status;
    DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo=await deviceInfoPlugin.androidInfo;

    if(androidDeviceInfo.version.sdkInt<=32){
      status=await Permission.storage.request();
    }else{
      status=await Permission.mediaLibrary.request();
    }
    //
    if(status==PermissionStatus.granted){
      Get.defaultDialog(
          title: "Choose Image",
          middleText: "Pick an image from the camera or gallery?",
          actions: [
            ElevatedButton(
                onPressed: (){
                  selectedImage("camera");
                },
                child: Text('Camera')
            ),
            ElevatedButton(
                onPressed: (){
                  selectedImage("gallery");
                },
                child: Text('Gallery')
            ),
          ]

      );
    }

    if(status== PermissionStatus.denied){
      Get.snackbar("Error", "Please allow permission for further usage..");
      openAppSettings();
    }
    if(status== PermissionStatus.permanentlyDenied){
      Get.snackbar("Error", "Please allow permission for further usage..");
      openAppSettings();
    }
  }

  Future<void> selectedImage(String type)async{
    List<XFile> imgs=[];
    if(type=='gallery'){
      try{
        imgs=await _picker.pickMultiImage(imageQuality: 80);
        update();
      }catch(e){
        Get.snackbar("Error", "error gallery not open");
      }
    }else{
      final img=await _picker.pickImage(source: ImageSource.camera,imageQuality: 80);

      if(img != null){
        imgs.add(img);
        update();
      }
    }
    if(imgs.isNotEmpty){
      selectedImages.addAll(imgs);
      update();
      print(selectedImages.length);
    }
  }

  void removeImage(int index){
    selectedImages.removeAt(index);
    update();
  }
}