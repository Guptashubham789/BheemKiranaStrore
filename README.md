# groceryapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Step 1:
-------
Sabse phle hmae firebase se connect karna hai firebase cli se 

Step 2:
---------
Ab hmara yah kaam ki hum ab directory ko create kar le jaise (ontrollers,modals,screens,services,widget,utils).

Step 3:
-------
Keyboard ko focus karna and unfocus karna :=
import :'material.dart'
class KeyboardUtil{
static void  hideKeyboard(BuildContext context){
FocusScopeNode currentFocus=FocusScope.of(context);

    //if hmara keyboard open hai to usko band kar do
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
}
}

Step 4: Splash Screen
--------
void initState() {
// TODO: implement initState
super.initState();
Timer(Duration(seconds: 5),(){
Get.offAll(()=>MainScreens());
});
}

Step 5: Welcome Screen
----------------------
Step 6: Login /SignUp Screen
----------------------------
Step 7: Google Sign
---------------------
sabse phle SH keys genrate karna
b9:ed:ba:46:ea:73:3d:20:09:03:9e:d0:8d:9b:12:5d:3b:17:a1:37
Package ko import karna (google_sign_in)
phir hme ek user ka model bnana hai and usme hme (userdevicetoken,isAdmin,isActive,createdOn) ye field lena compulesorry hai,
1. ab hum ek controller bnayenge google-sign-in name esko hum welcome screen ke button par call karwayenge
2.  google-sign-in-controller

class GoogleSignInController extends GetxController{
//jo maine package import kiya hai uska instance bnaa lenge
final GoogleSignIn googleSignIn=GoogleSignIn();
final FirebaseAuth _auth=FirebaseAuth.instance;


      Future<void> signInWithGoogle() async{
      final GetDeviceTokenController _getDeviceTokenController=Get.put(GetDeviceTokenController());
      try{
      final GoogleSignInAccount? googleSignInAccount=
      await googleSignIn.signIn();
      //yani ki jab acc apna select and click karwayenge to tb mai dekhna chah rha hu ki
      //hmara acc empty to nhi hai
      if(googleSignInAccount!=null){
      EasyLoading.show(status: "Please wait..");
      final GoogleSignInAuthentication googleSignInAuthentication=
      await googleSignInAccount.authentication;
      //jb user login kar rha hoga to uski creadential le lenge
      //creadential method ke andr 2 chije req hoti h id token
      final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken:googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
      );
      //ab hme dekhna h user credential ki kya yah khali to nhi hai
      final UserCredential userCredential=
      await _auth.signInWithCredential(credential);
      
              //jo bhi user yha se login ho rha hoga to uski detaild usercredential me save ho jaayegi
          final User? user=userCredential.user;

          //ab hmara user yha tk aa jaye to hme condition lgana hoga

        if(user != null){
            Usermodel usermodel=Usermodel(
                uId: user.uid,
                username: user.displayName.toString(),
                email: user.email.toString(),
                phone: user.phoneNumber.toString(),
                userImg: user.photoURL.toString(),
                userDeviceToken: _getDeviceTokenController.deviceToken.toString(),
                country: '',
                userAddress: '',
                street: '',
                userCity: '',
                isAdmin: false,
                isActive: true,
                createdOn: DateTime.now(),
            );
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set(usermodel.toMap());
            EasyLoading.dismiss();
            Get.offAll(()=> const MainScreens());
        }
      }
    }catch(e){
      EasyLoading.dismiss();
      print("Error : $e");
    }
      }
      
      }

Step 8: Controoller bnana hai GoogleSignIn name ka and use extends karna hoga GetxController se
---------------
yha par hum package ka instance lenge phir ek future void method bnayenge phir uske pura process karenge

Step 9 : email signup and verify acc email then login
---------------------
to sabse phle ek controller bnayenge uske andr firestore and firebaseaut ka instance create karenge
phir uske andr hum ek method bnayenge phir usko phle signin with email pass se sign karenge phir sign karne ke
baad user ko ek email send karenge ki verify karne ke liye and phir uske data ko firebastore data base me store karenge
phir hum aayenge screen par controller bnayenge textfield ka

Step 10: password show hide karna :
--------------------
//for password visibilty
var isPasswordVisible = false.obs;
textfield ko wrap kar denge Obs(()=>
obscureText: signUpController.isPasswordVisible.value,

suffixIcon: GestureDetector(
onTap: (){
signUpController.isPasswordVisible.toggle();
},
child:signUpController.isPasswordVisible.value? 
Icon(Icons.visibility_off):
Icon(Icons.visibility),
),
),

Step 11: Login karna hai verify karke email ko
----------------
sabse phle hme ek signInController bnana hoga then uske baad hme uske andr future method bnana hoga then uske 2 
parameter pass karna hoga email pass ka phir hme vha pr signinwithemailandpassword ka kuch likhna hoga
phir hme screen par aana hoga btn ke click event pr if condition lga kar check karna hoga ki koi field khali to nhi hai
phir hme controoler me bnaye gye method ko call karna hoga usme kuch controller ke parameter ko pass karna hoga phir
hme ek condition dena hoga ki email hmara verify hai ya nhi agr nhi h to phle jaao verify karo tb jaake login  karna.

Step 12 : Forgot Password (agr user pass bhool jata hai to kaise forgot karwa sakte h)
-------------------------------------------------------------------------------------
forget karte time hme usercredential ki need nhi padti hai and hme ek controller bnana hoga then uske andr hme ek method bnana hoga us method ke andr hme 
firebase auth ka instance leke method ko get karna hai sentemailforget name ka yh methos ek parameter lega jo hme textfield se get krenge ,

Step 13: DeviceToken Get karna:
---------------------------------
Device token ka use hm notification sent karne ke liye karte hai 
sabse phle hum ek controller bnayenge phir ek var bnayenge devicetoken name se phir ek method bnayenge oninit() name ka uske andr
ek method pass karenge and phir init method ke baad ek method bnayenge getDeviceToken name se hme ek package import karna hoga 
firebase_messaging name ka

String? token=await FirebaseMessaging.instance.getToken();

      if(token!=null){
        deviceToken=token;
        print("token: $token");
        update();
      }

Step 14 :(Es lecture me hum multideshboard ko kaise handle karenge)
------------------------------------------------
hme sabse phle ek controller bnana hoga getUserData and uske andr hme firestore database ka instance lena hoga 
phir hme ek future method bnana hoga uske andr uid aayega hmara user ka phir hme where condition lgana hoga agr id dono ki same hai to pura collaction
hme return karke dega controler the us controller ko hm signin screen ke
button ke ander check karenge  agr
//ye code multideshboard handle karne ke liye hai user ki uid ko check krega
var userData=await getUserDataController.getUserData(userCredential!.user!.uid);
if(userData[0]['isAdmin']==true){
Get.offAll(()=>AdminMainScreen());
Get.snackbar("Success Admin", "login successfully!",
snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
colorText: AppConstant.appTextColor);
 }else{
Get.offAll(()=>MainScreens());
Get.snackbar("Successfully User Login!", " ",
snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
colorText: AppConstant.appTextColor);
}

Step 15 : ab hme yah dekhna hai agr user ek baar login ho gaya to use bar bar login nhi karna pde
------------------------------------------------------------------------
sabse phle spalash screen pr jana hai phir vha hme firebaseauth se current user ko get karna hai
phir hme ek method bnana hai future phir es future method ko timer method ke andr pass karna hai,

Future<void> loggdin(BuildContext context) async{
if(user!=null){
final GetUserDataController getUserDataController=Get.put(GetUserDataController());
//agr user ne login kiya hai to
var userData=await getUserDataController.getUserData(user!.uid);
if(userData[0]['isAdmin']==true){
Get.offAll(()=>AdminMainScreen());
}else{
//userscreen
Get.offAll(()=>MainScreens());
}
}else{
//agr user hmara login nhi kiya hai to hum usko bhej denge welcome screen pe
Get.to(()=>WelcomeScreen());
}
}

Step 16 : Ab hme drawer bnana hai
----------------------------------
hme ek drawer ka widget bnana hai aur us widget ko main screen me
drawer:DrawerWidget();
ko call kar dena hai

Step 17 : Slider lgana hai 
----------------------------
sabse phle hme package ko insert karna hai
carousel_slider:  , 
cached_network_image: ,
hme firebase ke ander ek collaction bnana hai 
banners --> 4  img --> fieldsname (imageUrl) hmw ek hi field lena hai 
ab hme ek controller bnana hai banner-controllers eske andr RxList name ka var bnana hai
and ek method bnana hai us method ke ander hme firestore database banners name ke collation ko get karna hai
and gate kiye gye document ko rxlist name ka var par document ko save karna hai

Obx()=> yah hme help karta hai real time changes dekhne ke liye
ek widget bnayenge bannerwidget name ka and uske ander hum static ui bnayenge then usko hum main screen pr call kar denge

Step 18 : (Heading Widget)
---------------------------
1.Hme ek widget bnana stateless widget and uske and kuch widget bnane hai jaise heding,subheading,buttonText,ontap method,
phir hme main screen pr call karna hai widget ko

Step 19: (ab hum category ko fetch karna dekhenge)
------------------------------------------------------------------------
1.hme sabse phle database ke andr ek collaction  bnana hai (categories) name and uske andr hme 
total 5 field lene hai jaise (categoryId,categoryImg,categoryName,createdAt,updatedAt)
2.image_card: pakage
3.fir hme ek widget bnana hai uske andr hum return karenge futurebuilder and uske amdr 2 parameter aate hai ek 
future:eske ander hum firebasefirestore se collaction ko get karenge
builder:eske ander hum buildContext pass karenge and index and snapshot
phir 3 condition lagayenge jaise error waitting, empty and null 
phir hme category ko fetch karna hai main screen pr



Step 20: (Flash Sale)
---------------------
sabse phle hme kuch product ko add kar lena hai apne firebase me and collaction ka name (product) rkhna hai and uske andr hme kuch field dene hai jaise
(categoryId,categoryName,createdAt,productId,productName,salePrice,fullPrice,productImages list type,deliveryTime,isSale bool,productDescription,createdAt dynamic,updatedAt)
same jaise hum logo ne category ko fetch kiya tha vaise hi sale ko fetch karenge but future me condition lgayenge 
FirebaseFireStore.instace.collaction('product).where('isSale',isEqualTo:true).get();

Step 21 :(agr hum category ke see more pr click kare to all category show jo jaaye new screen)
---------------------------------
sabse phle hme ek screen bnana hoga uske baad body me hme return karna hoga futurebuilder ko then uske andr hum gridView.builder lenge
ye sab hum category-widget se copy karenge 

Step 22:(Ab hum category ke click karne pr uske andr jitne bhi product hai vh show karvayenge)
--------------------------------------------------------------------------------------------
(kisi spacefic ategory pr click kare usse related jitne bhi product ho usko kaise dikhaa sakte hai)
hme ek singlCategoriesScreen name ka widget bnana hai and jaha par maine categody ko show karwaya tha us screen se hme categoriesId ko bhejna hai sigleCategoryScreen pr jisse hum id
ke throgh hum product ko get kar sakte , phir hme condiction lgana hai id ke base ki
and hme product model ko lgana hoga uske andr 

Step 23 : (all flash sale ko show karwana )
--------------------------------------------
AllFlashSaleProduct jaise hum log category ko kiye the same vaise hi flash sale ko bhi karenge bs diff yah rhega ki
hme vha condition dena hoga wher('isSale',isEqualTo:true).get()
phir hme productModel ko fetch karna hai bs etna hi aage aap khud kar loge

Step 24 :(Yaha par hum main screen pr product ko show karana dekhenge)
----------------------------------------
hme sbse phle ek widget bnana hai allproductwidget name ka and uske ander hme ek query kya lgana hai jaise hmara jo sale ka product hai vh hme show na ho 
aur jo sale me product hai vh hme dikhayi de bs ('isSale',isEqualTo:false).get() ye query lgana hai and hme gridview lena hai uske andr kuch ui design karna hai bs 
 2. ab hme see more par click kare to all product show ho next screen par to eske liye kya karenge hum 
3. sabse pahle ek screen bnaana hai allproductscreen name se and usme allproductwidget ko copy karna hai bs name ko change kar dena hai aur kuch nhi

Step 25 :(agr hum kisi spacefic product pr click kre to usko kaise detail screen pr le ja sake)
----------------------------------
sabse phle hme kisi product pr click event bnana hoga and jab product pr click kare to product ka data hme dusre 
screen par le jana hai model ke basis par
(productModel:productModel)
dusre screen pr ProductModel productModel; required this.productModel;
1. Ab hme slider ko lgana hai to hum sabse phle banner widget ke andr slider ko copy karenge phir use hum singleproductscreen pr column ke andr paste karenge
hme crouselslider ke ander ek attribute hai item name ka uske andr hme yah pass karna hai (items: widget.productModel.productImages.)
2. phir eske baad hme categoryname,price,delivery,description,and favorite icon,and 2 button dena hai Add to cart , and Whatsapp ka.


Step 26 : (Esme hum yeh dekhenge ki agr hum kisi flash sale product pr click kr rhe h to uske product ko details screen par kaise dikhayenge)
--------------------------------------------------------------------------------------
1. sabse phle jana hai flash widget pr vha se hme productmodel ko send karna h singlproductscreen pr
2. hme kuch nhi karna bs condition lgana hai price pr
3. Container(
   alignment: Alignment.topLeft,
   child: Row(
   children: [
    //agr hmari condition true hogi to sale ki price return hogi agr condition true nhi hogi to fullprice return hogi
   widget.productModel.isSale==true && widget.productModel.salePrice!=''?
   Text("Price : "+widget.productModel.salePrice):Text("Price : "+widget.productModel.fullPrice),
   ],
   )),
4. ab hme sab product ko dekh lena hai click krke ki sab product hmara details screen par jaa rha hai ya nhi 
   agr nhi jaa rha hai to use hum shi kar lenge 

Step 27 :(cart screen jab hum add to cart kare to hmara product cart screen me aa jaaye )
---------------------------------------------------------------
1. ek screen bnana hai cartscreen.dart usme statefullwidget lena hai
2. aur esme hum scaffold return karwayenge and body me hum Listview.builder return karenge uske andr hum ListTile return karenge phir cart ka design karenge 
3. phir hum ek widget lenge bottomNavigationBar jo ki niche hme ek button and total ammount calculate karke dikhe

Step 28 : (esme hum yeh dekhenge ki kisi product par jaake add tocart karte hai to usko kaise cart screen me add karenge)
------------------------------------------------------------------
1. sabse phle hme model bnana hai same product ki trh hi rhega bs esme 2 cheeje aur add karni hai (
2. final int productQuantity; final double productTotalPrice;)
3. hme singleproductdetails par jana hai vha par ek method bnana hai and usse  phle hme current user ka instance lena hai
4. Future<void> checkProductExistence({
   required String uId,
   int quantityIncrement=1,
   }) async{
   //hme hr bande ko usi ke cart ke product dikhane mtlb ki uska  ek document bnayenge
   //alg alg user ka alg alg documnet hoga and eska collection
   final DocumentReference documentReference=
   FirebaseFirestore.instance
   .collection('cart')
   .doc(uId)
   .collection('CartOrders')
   .doc(widget.productModel.productId.toString());

   //snapshot ke ander hmne document ko get kar lena hai
   DocumentSnapshot snapshot=await documentReference.get();

   //agr hmara product add ho jayega cart screen me to hum bs uske quantity ko update karenge
   if(snapshot.exists){
   int currentQuantity=snapshot['productQuantity'];
   int updateQuantity=currentQuantity + quantityIncrement;
   double totalPrice=double.parse(widget.productModel.fullPrice)*updateQuantity;

   await documentReference.update({
   'productQuantity':updateQuantity,
   'productTotalPrice':totalPrice,
   });
   print('product exist');

   }else{
   //jb hmara product exist nhi karta cart me tb use hme database me send karne ke liye
   //this is a subcollaction
   await FirebaseFirestore.instance.collection('cart').doc(uId).set({
   'uId':uId,
   'createdAt':DateTime.now(),
   });
   //yeh cart collaction ke andr ek aur collaction bnayega order

   CartModel cartModel=CartModel(
   productId: widget.productModel.productId,
   categoryId: widget.productModel.categoryId,
   productName: widget.productModel.productName,
   categoryName: widget.productModel.categoryName,
   salePrice: widget.productModel.salePrice,
   fullPrice: widget.productModel.fullPrice,
   productImages: widget.productModel.productImages,
   deliveryTime: widget.productModel.deliveryTime,
   isSale: widget.productModel.isSale,
   productDescription: widget.productModel.productDescription,
   createdAt: DateTime.now(),
   updatedAt: DateTime.now(),
   productQuantity: 1,
   productTotalPrice: double.parse(widget.productModel.fullPrice),
   );

   await documentReference.set(cartModel.toMap());
   print('product add');

   }

}

Step 29 : (isSale fullprice me query lgana hai kyuki db me phle fullprice jaa rha tha )
------------------------------------------------
double totalPrice=
double.parse(widget.productModel.isSale? widget.productModel.salePrice:widget.productModel.fullPrice)*updateQuantity;
---------
Step 30 :(Ab hme cart screen me data ko fetch karna hai)
--------------------------------
sabse phle hum body ke andr return karenge future.builder uske ander query lgayenge
future: FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('CartOrders').get(),
phir ek cartmodel ko add karenge phir cart model ke thruogh hum data ko show karenge 

Step 31 :(Cart screen me se product ko kaise delete karte hai)
----------------------------------------
1. flutter_swipe_action_cell: es package ko add karna hai
2. cart screen pr hmne ek card bnaya hai usko wrap kar denge SwipeActionCell(key:ObjectKey(cartModel.productId),child:Card());
3. key: ObjectKey(cartModel.productId),
   trailingActions: [
   SwipeAction(
   backgroundRadius: 10.0,
   title: "Delete",
   forceAlignmentToBoundary: true,
   performsFirstActionWithFullSwipe: true,
   onTap: (CompletionHandler handler) async{
   print('delete');
   await FirebaseFirestore.instance
   .collection('cart')
   .doc(user!.uid)
   .collection('CartOrders')
   .doc(cartModel.productId)
   .delete();
   })
   ],
4. agr hme real time changes dekhna hai to hme future.builder ki jgh strembuilder lena hoga and stream: get() ki jgh snapshot() pass karna hoga

Step 32 : (How to increase and decrease product quantity )
---------------------------------------------------------
1. Sabse phle hme button ko wrap karna hoga gesturedetector widget se 
   phir uske ontap method ke andr ek if condition dena hai 
2.  if(cartModel.productQuantity>1){
    await FirebaseFirestore.instance
    .collection('cart')
    .doc(user!.uid)
    .collection('CartOrders')
    .doc(cartModel.productId)
    .update({
    'productQuantity':cartModel.productQuantity-1,
    'productTotalPrice':
    (double.parse(cartModel.fullPrice)*
    (cartModel.productQuantity-1)),
    });
    }
3. if(cartModel.productQuantity>0){
   await FirebaseFirestore.instance
   .collection('cart')
   .doc(user!.uid)
   .collection('CartOrders')
   .doc(cartModel.productId)
   .update({
   'productQuantity':cartModel.productQuantity+1,
   'productTotalPrice':
   double.parse(cartModel.fullPrice)+
   double.parse(cartModel.fullPrice)*
   (cartModel.productQuantity),
   });
   }

Step 33 :(How to calculate cart products price)
-----------------------------------------------
1. ek controller bnana hoga  uske CartTotalPrice name ka uske andr ek Rx var bnana h and uske baad init() method bnana hai and uske baad ek
   hme ek method bnana hai jiske andr hum user ke CartOrders ke all document ko fetch karenge
   import 'package:cloud_firestore/cloud_firestore.dart';
   import 'package:firebase_auth/firebase_auth.dart';
   import 'package:get/get.dart';
      
      class ProductPriceController extends GetxController{
      RxDouble totalPrice=0.0.obs;
      User? user=FirebaseAuth.instance.currentUser;
      
      
      @override
      void onInit() {
      fetchProductPrice();
      super.onInit();
      
      }
      
      void fetchProductPrice() async{
      final QuerySnapshot<Map<String,dynamic>> snapshot=
      await FirebaseFirestore.instance
      .collection('cart')
      .doc(user!.uid)
      .collection('CartOrders')
      .get();
      
          double sum=0.0;
      
          for(final doc in snapshot.docs){
            final data=doc.data();
            //sab document ke andr se mujhe totalprice ki field chahiye
            if(data!=null && data.containsKey('productTotalPrice')){
              sum+=(data['productTotalPrice'] as num).toDouble();
            }
          }
          totalPrice.value=sum;
      }
      }
3. Padding(
    padding: const EdgeInsets.all(8.0),
    child: Obx(()=>Text("Total : ${productPriceController.totalPrice.value.toStringAsFixed(1)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: AppConstant.appFontFamily),),),
    ),

Step 34 : (How to make checkout page in flutter )
-------------------------------------------------
cart screen ko copy karenge and ek new screen bnayenge uska name denge checkoutscreen uske andr pura cart ke screen ko paste kar denge
and uske andr se increement and decrement quantity ko htaa denge and conform button pr ek pop show karwayenge usme user ka data input 
karwayenge jaise name address near by contact nu ye phir ek button bnayenge place order ka uspr click karne par user ka order confirm ho jayenge 
and ek new collaction bnega conformorders ka jisme product rhega usme kuch 
showCustomBottomSheet();
bottomsheet ke ander hme inputfield bnana hai and ek button bnana hai

Step 35 :(Placing an order in flutter Part-1 )
----------------------------------------------
1. Sabse phle hum model bnayenge uske ander hum cartmodel ke pure data ko lenge and alg se hum ek 
  status , name ,phone,nearby,fulladdress, deviceToken ;> esliye lenge ki hum baad me notification bhi send kar sake ki apka order deliver ho ggya hai
2. Hme 4 controller bnana hoga.
3. hme ek controller bnana hoga (get-customer-device-token.dart)

      Future<String> getCustomerDeviceToken() async{
      try{
      String? token=await FirebaseMessaging.instance.getToken();
      if(token!=null){
      return token;
      }else{
      throw Exception("Error");
      }
      }catch(e){
      print("Error: $e");
      throw Exception("Error");
      }
      }


4. hme ek service bnana hai genrate-order-id name ka uske andr hum unique order id ko fetch karenge
   
   import 'dart:math';

   String genrateOrderId(){
   DateTime now=DateTime.now();
   
   int randomNumber=Random().nextInt(9999);
   String id='${now.microsecondsSinceEpoch}$randomNumber';
   return id;
   }

5. and hum ek service bnayenge uske andr hum documnet ko fetch karenge ek ek karke and uske andr order id ko bhi k
   gate karenge. loop bhi lgana hai ek karke hme cartorder se data ko fetch karna hai
      
      
      import 'package:cloud_firestore/cloud_firestore.dart';
      import 'package:firebase_auth/firebase_auth.dart';
      import 'package:flutter/material.dart';
      import 'package:flutter_easyloading/flutter_easyloading.dart';
      import 'package:get/get.dart';
      import 'package:get/get_core/src/get_main.dart';
      import 'package:get/get_navigation/src/snackbar/snackbar.dart';
      import 'package:groceryapp/modals/order-model.dart';
      import 'package:groceryapp/screens/user-panel/main-screen.dart';
      
      import '../utils/app-constant.dart';
      import 'genrate-order-id-service.dart';
      
      void placeOrder({
      required BuildContext context,
      required String customerName,
      required String customerPhone,
      required String customerNerBy,
      required String customerAddress,
      required String customerDeviceToken
      }) async{
      
      final user=FirebaseAuth.instance.currentUser;
      EasyLoading.show(status: "Please wait!!");
      if(user!=null){
      try{
      
            //jo bhi user h uske cartOrder me pure cart item ko fetch kar liya hai
            //
            QuerySnapshot querySnapshot=await FirebaseFirestore.instance
                .collection('cart')
                .doc(user.uid)
                .collection('CartOrders').get();
            //jitne bhi docs honge es list ke andr show karwa lenge
            List<QueryDocumentSnapshot> documents=querySnapshot.docs;
            for(var doc in documents){
              Map<String,dynamic>? data=doc.data() as Map<String,dynamic>;
      
              String orderId=genrateOrderId();
      
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
                customerId: user.uid,
                status: false, //starting me false send karenge
                customerName: customerName,
                customerPhone: customerPhone,
                customerNearBy: customerNerBy,
                customerAddress: customerAddress,
                customerDeviceToken: customerDeviceToken,
              );
              for(var x=0; x<documents.length;x++){
                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(user.uid)
                    .set({
                      'uId':user.uid,
                      'customerName':customerName,
                      'customerPhone':customerPhone,
                      'customerAddress':customerAddress,
                      'customerDeviceToken':customerDeviceToken,
                      'orderStatus':false,
                      'createdAt':DateTime.now()
                    },
                );
                //upload Orders
                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(user.uid)
                    .collection('ConfirmOrders')
                    .doc(orderId)
                    .set(orderModel.toMap());
                
                //delete cart product
                await FirebaseFirestore.instance
                    .collection('cart')
                    .doc(user.uid)
                    .collection('CartOrders')
                    .doc(orderModel.productId.toString())
                    .delete().then((value){
                      print("Delete cart product");
                });
              }
            }
            print("Order Confirmed");
            Get.snackbar("Order Confirmed", "Thank You For Order!!",
                snackPosition: SnackPosition.BOTTOM,backgroundColor: AppConstant.appMainColor,
                colorText: AppConstant.appTextColor,
              duration: Duration(seconds: 5),
            );
            EasyLoading.dismiss();
            Get.offAll(()=>MainScreens());
          }catch(e){
            print("Error: $e");
          }
      }
      
      }

Step 36 :(Send message on whatsapp using flutter)
--------------------------------------------------

Step 37 :(How to fetch user orders from firebase )
--------------------------------------------------
1. sabse phle ek screen bnana hai and cart wale screen se pura copy karna hai and es wale screen me paste karna hai
2. Ab hme yha orders ke collactio ke andr sub collaction ki query ko lgana hai and vha se data ko fetch karna hai 
3. ab ek query lgana hai agr status false ho to pending dikhana hai agr status true ho to deleverd dikhana hai and ek delete ka button lgana hai




































































































































































