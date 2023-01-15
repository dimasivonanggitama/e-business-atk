import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DBMSFirestoreService {
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _dbStorage = FirebaseStorage.instance;
  
  Future addData(String colletionReference, dynamic submittedData) async {
    await _dbFirestore.collection(colletionReference).add(submittedData.toMap());
  }

  Future addDataWithCustomDocumentID(String documentID, String colletionReference, dynamic submittedData) async {
    await _dbFirestore.collection(colletionReference).doc(documentID).set(submittedData.toMap());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData(String collectionReference) async {
    return await _dbFirestore.collection(collectionReference).get();
  }
}