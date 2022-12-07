import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  // bool? isVerified;
  final String? address;
  final String? email;
  String? password;
  final String? fullName;
  final String? phoneNumber;
  // UserModel({this.uid, this.email, this.password, this.displayName, this.age, this.isVerified});
  UserModel({this.uid, this.address, this.email, this.password, this.fullName, this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'alamat': address,
      'email': email,
      'nama': fullName,
      'password': password,
      'nomorHP': phoneNumber,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : uid = doc.id,
      address = doc.data()!["alamat"],
      email = doc.data()!["email"],
      fullName = doc.data()!["nama"],
      phoneNumber = doc.data()!["nomorHP"];
      
  UserModel currentValue({
    // bool? isVerified,
    String? uid,
    String? address,
    String? email,
    String? fullName,
    String? password,
    String? phoneNumber,
    String? status,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      address: address ?? this.address,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      // isVerified: isVerified ?? this.isVerified
    );
  }
}