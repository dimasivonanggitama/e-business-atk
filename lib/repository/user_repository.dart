import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../../models/user_model_example_project.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

// abstract class UserRepositoryAbstract {
//   Stream<UserModel> getCurrentUser();
//   Future<void> saveUserData(UserModel user);
//   Future<UserCredential?> signUp(UserModel user);
//   Future<UserCredential?> signIn(UserModel user);
//   Future<void> signOut();
//   // Future<String?> retrieveUserName(UserModel user);
// }

class UserRepository /*implements UserRepositoryAbstract*/ {
  UserService service = UserService();

  // @override  
  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  // Future retrieveUserID(UserModel user) {
  //   return ;
  // }

  Future<UserModel> retrieveUserData(String userID) async {
    var snapshot = await service.getUserData(userID);

    return snapshot.get().then(
      (docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>)
    );
  }

  // @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  // @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  // @override
  Future<void> signOut() {
    return service.signOut();
  }

  // @override
  // Future<String?> retrieveUserName(UserModel user) {
  //   return dbService.retrieveUserName(user);
  // }
  
  // @override
  Future<void> saveUserData(UserModel user) {
    return service.setUserData(user);
  }
}