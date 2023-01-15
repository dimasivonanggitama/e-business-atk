part of 'dbms_firestore_bloc.dart';

abstract class DBMSFirestoreEvent extends Equatable {
  const DBMSFirestoreEvent();
  
  @override
  List<Object> get props => [];
}

class CollectionRequested extends DBMSFirestoreEvent {

  // CollectionRequested();
  
  @override
  List<Object> get props => [];
}

class FirstFieldOnChanged extends DBMSFirestoreEvent {
  final String firstFieldValue;

  FirstFieldOnChanged(this.firstFieldValue);
  
  @override
  List<Object> get props => [firstFieldValue];
}

class SecondFieldOnChanged extends DBMSFirestoreEvent {
  final String secondFieldValue;

  SecondFieldOnChanged(this.secondFieldValue);
  
  @override
  List<Object> get props => [secondFieldValue];
}

class DeleteCollectionTriggered extends DBMSFirestoreEvent {
  final String collectionName;

  DeleteCollectionTriggered(
    this.collectionName
  );
  
  @override
  List<Object> get props => [collectionName];
}

class DuplicateCollectionTriggered extends DBMSFirestoreEvent {
  // final String newCollectionName;
  // final String collectionNameTarget;

  DuplicateCollectionTriggered(
    // this.collectionNameTarget,
    // this.newCollectionName
  );
  
  @override
  List<Object> get props => [
    // collectionNameTarget,
    // newCollectionName
  ];
}