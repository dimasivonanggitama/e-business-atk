part of 'dbms_firestore_bloc.dart';

abstract class DBMSFirestoreState extends Equatable {
  const DBMSFirestoreState();
  
  @override
  List<Object> get props => [];
}

class DBMSFirestoreInitial extends DBMSFirestoreState {
  final String firstFieldErrorMessage;
  final String firstFieldValue;
  final bool isFirstFieldEmpty;
  final bool isFirstFieldEverTyped;
  final String secondFieldErrorMessage;
  final String secondFieldValue;
  final bool isSecondFieldEmpty;
  final bool isSecondFieldEverTyped;

  DBMSFirestoreInitial({
    required this.firstFieldErrorMessage,
    required this.firstFieldValue,
    required this.isFirstFieldEmpty,
    required this.isFirstFieldEverTyped,
    required this.secondFieldErrorMessage,
    required this.secondFieldValue,
    required this.isSecondFieldEmpty,
    required this.isSecondFieldEverTyped
  });

  DBMSFirestoreInitial currentValue({
    String? firstFieldErrorMessage,
    String? firstFieldValue,
    bool? isFirstFieldEmpty,
    bool? isFirstFieldEverTyped,
    String? secondFieldErrorMessage,
    String? secondFieldValue,
    bool? isSecondFieldEmpty,
    bool? isSecondFieldEverTyped
  }) {
    return DBMSFirestoreInitial(
      firstFieldErrorMessage: firstFieldErrorMessage ?? this.firstFieldErrorMessage,
      firstFieldValue: firstFieldValue ?? this.firstFieldValue,
      isFirstFieldEmpty: isFirstFieldEmpty ?? this.isFirstFieldEmpty,
      isFirstFieldEverTyped: isFirstFieldEverTyped ?? this.isFirstFieldEverTyped,
      secondFieldErrorMessage: secondFieldErrorMessage ?? this.secondFieldErrorMessage,
      secondFieldValue: secondFieldValue ?? this.secondFieldValue,
      isSecondFieldEmpty: isSecondFieldEmpty ?? this.isSecondFieldEmpty,
      isSecondFieldEverTyped: isSecondFieldEverTyped ?? this.isSecondFieldEverTyped
    );
  }
  
  @override
  List<Object> get props => [
    firstFieldErrorMessage,
    firstFieldValue,
    isFirstFieldEmpty,
    isFirstFieldEverTyped,
    secondFieldErrorMessage,
    secondFieldValue,
    isSecondFieldEmpty,
    isSecondFieldEverTyped
  ];
}