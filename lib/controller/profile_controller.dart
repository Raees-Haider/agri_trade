import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  static ProfileController instance=Get.find<ProfileController>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = ProfileModel().obs;
  RxBool loading = false.obs;

  Future getUserDetails() async {
    //simple this also return uid,
    final res = await _db.collection('users').doc(auth.currentUser?.uid).get();
//pass model in obs to manage the state if we use simple variable we need to use set state in init state
    user.value = ProfileModel.fromJson(res.data()!);
     print(user.value.uid);
    update();
  }

  Future getFarmerProfile() async {
    //
    var res = await _db.collection('farmers').doc(auth.currentUser?.uid).get();
    user.value = ProfileModel.fromJson(res.data()!);
    // print(user.value.email);
    update();
  }

}
