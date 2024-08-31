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

















































































