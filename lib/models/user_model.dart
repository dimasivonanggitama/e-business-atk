import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? address;
  final String? email;
  final String? name;
  String? password;
  String? phoneNumber;
  final String? status;
  final String? userID;
  UserModel({this.address, this.email, this.password, this.name, this.phoneNumber, this.status, this.userID});

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : userID      = doc.id,
      address     = doc.data()!["address"],
      email       = doc.data()!["email"],
      name        = doc.data()!["name"],
      status      = doc.data()!["status"],
      password    = doc.data()!["password"],
      phoneNumber = doc.data()!["phoneNumber"];

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'email': email,
      'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'status': status
    };
  }
      
  UserModel currentValue({
    String? address,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? status,
    String? userID
  }) {
    return UserModel(
      address: address ?? this.address,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      userID: userID ?? this.userID
    );
  }
}