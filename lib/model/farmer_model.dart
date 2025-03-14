import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerModel {
  String? url;
  String? email;
  String? name;
  String? phone;
  String? uid;
  int? revenue;
  int? balance;
  String? role; // Added role field

  FarmerModel({
    this.url,
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.revenue,
    this.balance,
    this.role, // Added role parameter
  });

  // Updated fromJson to include 'role'
  FarmerModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['id'];
    revenue = (json['revenue'] is int)
        ? json['revenue']
        : (json['revenue'] as double?)?.toInt() ?? 0;
    balance = (json['balance'] is int)
        ? json['balance']
        : (json['balance'] as double?)?.toInt() ?? 0;
    role = json['role']; // Initialize role from JSON
  }

  // Updated toJson to include 'role'
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Url'] = this.url;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['id'] = this.uid;
    data['revenue'] = this.revenue;
    data['balance'] = this.balance;
    data['role'] = this.role; // Add role to toJson map
    return data;
  }

  // Updated fromSnapshot to include 'role'
  factory FarmerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FarmerModel(
      uid: data['id'],
      email: data['email'],
      name: data['name'],
      url: data['Url'],
      phone: data['phone'],
      revenue: (data['revenue'] is int)
          ? data['revenue']
          : (data['revenue'] as double?)?.toInt() ?? 0,
      balance: (data['balance'] is int)
          ? data['balance']
          : (data['balance'] as double?)?.toInt() ?? 0,
      role: data['role'], // Initialize role from Firestore data
    );
  }
}
