import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? url;
  String? email;
  String? name;
  String? phone;
  String? uid;
  String? address; // New field
  String? cnic; // New field

  ProfileModel({
    this.url,
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.address, // New field
    this.cnic, // New field
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['id'];
    address = json['address']; // New field
    cnic = json['cnic']; // New field
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['id'] = this.uid;
    data['address'] = this.address; // New field
    data['cnic'] = this.cnic; // New field
    return data;
  }

  factory ProfileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProfileModel(
      uid: data['id'],
      email: data['email'],
      name: data['name'],
      url: data['Url'],
      phone: data['phone'], // Added phone field
      address: data['address'], // New field
      cnic: data['cnic'], // New field
    );
  }
}
