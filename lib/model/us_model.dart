class UserModel {
  UserModel({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.address,
    required this.cnic,
    required this.phone,
  });

  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String lastActive;
  late String email;
  late String pushToken;
  late String address; // New field
  late String cnic; // New field
  late String phone; // New field

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['Url'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    address = json['address'] ?? ''; // New field
    cnic = json['cnic'] ?? ''; // New field
    phone = json['phone'] ?? ''; // New field
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Url'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['address'] = address; // New field
    data['cnic'] = cnic; // New field
    data['phone'] = phone; // New field
    return data;
  }
}
