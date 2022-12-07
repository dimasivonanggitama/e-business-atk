import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
// import '../../models/user_model_example_project.dart';

class UserService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;

  setUserData(UserModel userData) async {
    await _dbFirestore.collection("penggunaJasa").doc(userData.uid).set(userData.toMap());
  }

  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return  UserModel(uid: "uid");
      }
    });
  }

  // Future<List<UserModel>> retrieveUserData() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").get();
  //   return snapshot.docs.map(
  //     (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot)
  //   ).toList();
  // }

  // Future<String> retrieveUserName(UserModel user) async {
  //   DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").doc(user.uid).get();
  //   return snapshot.data()!["displayName"];
  // }

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email!,password: user.password!);
      // await verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}