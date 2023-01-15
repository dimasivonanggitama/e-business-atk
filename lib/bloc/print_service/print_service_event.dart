part of 'print_service_bloc.dart';

abstract class PrintServiceEvent extends Equatable {
  const PrintServiceEvent();

  @override
  List<Object> get props => [];
}

class FormSubmitted extends PrintServiceEvent {
  final String userID;
  FormSubmitted(this.userID);

  @override
  List<Object> get props => [userID];
}

class PrintPriceRequested extends PrintServiceEvent {

  @override
  List<Object> get props => [
  ];
}

class PrintPriceSubmitted extends PrintServiceEvent {
  final int colorfulPagePrice;
  final int greyscalePagePrice;
  PrintPriceSubmitted({required this.colorfulPagePrice, required this.greyscalePagePrice});

  @override
  List<Object> get props => [
    colorfulPagePrice,
    greyscalePagePrice
  ];
}

class TotalColorfulPagesChanged extends PrintServiceEvent {
  final int totalColorfulPages;
  TotalColorfulPagesChanged(this.totalColorfulPages);

  @override
  List<Object> get props => [totalColorfulPages];
}

class TotalGreyscalePagesChanged extends PrintServiceEvent {
  final int totalGreyscalePages;
  TotalGreyscalePagesChanged(this.totalGreyscalePages);

  @override
  List<Object> get props => [totalGreyscalePages];
}

class SelectFilePressed extends PrintServiceEvent{
  
  @override
  List<Object> get props => [];
}

class SnackBarDismissed extends PrintServiceEvent{
  
  @override
  List<Object> get props => [];
}

class ValueResetTriggered extends PrintServiceEvent{
  
  @override
  List<Object> get props => [];
}