import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesDropDownController extends GetxController{
  RxList<Map<String,dynamic>> categories=<Map<String,dynamic>>[].obs;

  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();

  }

  Future<void> fetchCategories() async{
    try{
    QuerySnapshot<Map<String,dynamic>> querySnapshot=await 
        FirebaseFirestore.instance.collection("categories").get();
      List<Map<String,dynamic>> categoriesList=[];
      querySnapshot.docs.forEach((DocumentSnapshot<Map<String,dynamic>> document){
        categoriesList.add({
          'categoryId':document.id,
          'categoryName':document['categoryName'],
          'categoryImg':document['categoryImg'],
        });
       },
      );
      categories.value=categoriesList;
      update();

    }catch(e){
      //Get.snackbar("Error"," $e ");
      print("Error $e");
    }
  }
  
  //set selected category
  
  void setSelectedCategory(String? categoryId){
    selectedCategoryId=categoryId?.obs;
    //Get.snackbar("selected category id", "${selectedCategoryId.toString()}");
    update();
  }

  //fetch category click karne pr name img,id, bhi aaye
  Future<String?> getCategoryName(String? categoryId) async{
    try{
      DocumentSnapshot<Map<String,dynamic>> snapshot=await
          FirebaseFirestore.instance.collection("categories").doc(categoryId).get();
      if(snapshot.exists){
        return snapshot.data()?['categoryName'];

      }else{
        return null;
      }
    }catch(e){
     // Get.snackbar("Errro", "${e.toString()}");
      return null;
    }
  }
  void setCategoryName(String? categoryName){
    selectedCategoryName=categoryName?.obs;
    // Get.snackbar("selected category name", "${selectedCategoryName.toString()}");
    update();
    return null;
  }
}