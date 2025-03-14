import 'dart:async';
import 'dart:io';

import 'package:agri_trade/model/us_model.dart';
import 'package:agri_trade/myapp.dart';
import 'package:agri_trade/screens/auth_screens/signup_screens/verify_screen.dart';
import 'package:agri_trade/screens/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

  RxString imagePath = ''.obs;
  final pickImage = Rxn<File>();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  static String? userName;
  static String? userEmail;
  static String? userId;
  static String? userUrl;
  static String? userPhone;
  RxBool loading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString verifyId = ''.obs;
  var url = ''.obs;

  //facebook user data variable
// simple signup with email and password
  Future<void> signUp({
    required String name,
    required String email,
    required String cnic,
    required String address,
    required String phone,
    required String password,
    required bool isFarmer,
  }) async {
    loading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (pickImage.value != null) {
          await uploadImageToFirebase();
        }

        if (isFarmer) {
          FirebaseFirestore.instance
              .collection("farmers")
              .doc(value.user!.uid)
              .set({
            'id': value.user!.uid,
            'name': name,
            'email': email,
            'cnic': cnic,
            'phone': phone,
            'address': address,
            'revenue': 0,
            'Url': url.value,
            'role': 'farmer',
          });
        } else {
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set({
            'id': value.user!.uid,
            'name': name,
            'email': email,
            'cnic': cnic,
            'phone': phone,
            'address': address,
            'revenue': 0,
            'Url': url.value,
            'role': 'user',
          });
        }
      }).then((value) => Timer(const Duration(seconds: 1), () {
                Get.snackbar("Sign Up successful", "You are Sign Up");
                Get.to(const VerifyScreen());
              }));
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } on FirebaseException catch (e) {
      Get.snackbar("Sign up Failed", "${e.message}",
          colorText: Colors.black,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255));
    }
    loading.value = false;
  }

//get user image from phone Gallery
  Future getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      pickImage.value = File(image.path);
      update();
    } else {
      //  print("no image selected");
    }
  }

//upload image to firebase storage
  Future uploadImageToFirebase() async {
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('images$imgId');
    var tst = await reference.putFile(pickImage.value!);
    //  print("valueeeeeeeeeeeeeee===== ${tst}");
    url.value = await reference.getDownloadURL();
    // print("url===== ${url.value}");
    update();
  }

//login to account using email and password
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    loading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        User? user = userCredential.user;
        // Timer(const Duration(seconds: 1), () {
        //   Get.to(()=>const AdminPortal());
        //  // Get.snackbar("Login successful", "You are loged In");
        // });
        emailController.clear();
        passwordController.clear();
      } else {}
    } on FirebaseException catch (e) {
      //  print("----------===${e}");

      Get.snackbar(
        "Login Failed",
        (e.message.toString()),
      );
    }
    loading.value = false;
  }

//login to using google account
  Future googleLogIn() async {
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    // Create a credential from the access token
    if (googleSignInAuthentication?.accessToken != null &&
        googleSignInAuthentication?.idToken != null) {
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      user = userCredential.user;
      Get.snackbar("Login successful", "You are loged In");
      //get data from google api and save it in local variables and then i will pass it to users collection
      userName = user?.displayName;
      userEmail = user?.email;
      userId = user?.uid;
      userUrl = user?.photoURL;
      userPhone = user?.phoneNumber;
      // Get.offNamed('/home');
      googleUserData(user!);
      Get.to(() => UserNavigationMenu());
    }
    return user;
  }

//after login data will be saved into firebase in users collection
//   Future<void> googleUserData(user) async {
//     final time = DateTime.now().millisecondsSinceEpoch.toString();
//     final googleUser = UserModel(
//       image: userUrl.toString(),
//       name: userName.toString(),
//       createdAt: time,
//       id: auth.currentUser!.uid,
//       lastActive: time,
//       email: userEmail.toString(),
//       pushToken: '',
//       address: '',
//       cnic: '',
//       phone: userPhone.toString(),
//     );
//     await firestore.collection('users').doc(user!.uid).set(googleUser.toJson());
//   }

//it will logout users login session

  Future<void> googleUserData(User user) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // Fetch existing user data from Firestore
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(user.uid).get();
    Map<String, dynamic>? existingData;
    if (documentSnapshot.exists) {
      existingData = documentSnapshot.data() as Map<String, dynamic>;
    }

    // Prepare the new user data, merging with existing data
    final googleUser = UserModel(
      image: userUrl.toString(),
      name: userName.toString(),
      createdAt:
          existingData?['createdAt'] ?? time, // Retain existing createdAt
      id: user.uid,
      lastActive: time,
      email: userEmail.toString(),
      pushToken: existingData?['pushToken'] ?? '', // Retain existing pushToken
      address: existingData?['address'] ?? '', // Retain existing address
      cnic: existingData?['cnic'] ?? '', // Retain existing cnic
      phone: userPhone != null
          ? userPhone.toString()
          : existingData?['phone'] ??
              '', // Use new phone if available, else retain existing
    );

    // Update or set the user data in Firestore
    await firestore
        .collection('users')
        .doc(user.uid)
        .set(googleUser.toJson(), SetOptions(merge: true));
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAll(AgriTrade());
      Get.snackbar("LogOut successful", "You are LogOut");
    } on FirebaseAuthException catch (e) {
      // print(e); // Displaying the error message
    }
  }

  Future<void> updateUserDetails({
    required String userId,
    String? newAddress,
    String? newPhone,
    String? newCnic,
  }) async {
    // Fetch existing user data from Firestore
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? existingData =
          documentSnapshot.data() as Map<String, dynamic>?;

      // Prepare the updated user data safely
      final updatedUser = UserModel(
        image: existingData?['image'] ?? '', // Use an empty string if null
        name: existingData?['name'] ?? '', // Use an empty string if null
        createdAt: existingData?['createdAt'] ??
            DateTime.now()
                .millisecondsSinceEpoch
                .toString(), // Default to now if null
        id: userId,
        lastActive: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // Update lastActive
        email: existingData?['email'] ?? '', // Use an empty string if null
        pushToken:
            existingData?['pushToken'] ?? '', // Use an empty string if null
        address: newAddress ??
            existingData?['address'] ??
            '', // Update address if provided
        cnic: newCnic ?? existingData?['cnic'] ?? '', // Update CNIC if provided
        phone: newPhone ??
            existingData?['phone'] ??
            '', // Update phone if provided
      );

      // Update the user data in Firestore
      await firestore
          .collection('users')
          .doc(userId)
          .set(updatedUser.toJson(), SetOptions(merge: true));
    } else {
      // Handle case where user does not exist (optional)
      print("User does not exist");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
