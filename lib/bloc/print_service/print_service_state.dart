part of 'print_service_bloc.dart';

abstract class PrintServiceState extends Equatable {
  const PrintServiceState();
  
  @override
  List<Object> get props => [];
}

class PrintServiceInitial extends PrintServiceState {
  final int colorfulPagePrice;
  final String documentID;
  final String errorMessage;
  final String filename;
  final String filePath;
  final File fileSelected;
  final int grandTotalPrice;
  final int greyscalePagePrice;
  final IconData iconSubmitButton;
  final bool isSnackBarShowedUp;
  final bool isSubmitButtonDisabled;
  final String textSubmitButton;
  final int totalColorfulPages;
  final int totalGreyscalePages;
  final int totalPriceofColorfulPages;
  final int totalPriceofGreyscalePages;

  PrintServiceInitial({
    required this.colorfulPagePrice,
    required this.documentID,
    required this.errorMessage,
    required this.filename,
    required this.filePath,
    required this.fileSelected,
    required this.grandTotalPrice,
    required this.greyscalePagePrice,
    required this.iconSubmitButton,
    required this.isSnackBarShowedUp,
    required this.isSubmitButtonDisabled,
    required this.textSubmitButton,
    required this.totalColorfulPages,
    required this.totalGreyscalePages,
    required this.totalPriceofColorfulPages,
    required this.totalPriceofGreyscalePages
  });

  PrintServiceInitial currentValue({
    int? colorfulPagePrice,
    String? documentID,
    String? errorMessage,
    String? filename,
    String? filePath,
    File? fileSelected,
    int? grandTotalPrice,
    int? greyscalePagePrice,
    IconData? iconSubmitButton,
    bool? isSnackBarShowedUp,
    bool? isSubmitButtonDisabled,
    String? textSubmitButton,
    int? totalColorfulPages,
    int? totalGreyscalePages,
    int? totalPriceofColorfulPages,
    int? totalPriceofGreyscalePages
  }) {
    return PrintServiceInitial(
      colorfulPagePrice: colorfulPagePrice ?? this.colorfulPagePrice,
      documentID: documentID ?? this.documentID,
      errorMessage: errorMessage ?? this.errorMessage,
      filename: filename ?? this.filename,
      filePath: filePath ?? this.filePath,
      fileSelected: fileSelected ?? this.fileSelected,
      grandTotalPrice: grandTotalPrice ?? this.grandTotalPrice,
      greyscalePagePrice: greyscalePagePrice ?? this.greyscalePagePrice,
      iconSubmitButton: iconSubmitButton ?? this.iconSubmitButton,
      isSnackBarShowedUp: isSnackBarShowedUp ?? this.isSnackBarShowedUp,
      isSubmitButtonDisabled: isSubmitButtonDisabled ?? this.isSubmitButtonDisabled,
      textSubmitButton: textSubmitButton ?? this.textSubmitButton,
      totalColorfulPages: totalColorfulPages ?? this.totalColorfulPages,
      totalGreyscalePages: totalGreyscalePages ?? this.totalGreyscalePages,
      totalPriceofColorfulPages: totalPriceofColorfulPages ?? this.totalPriceofColorfulPages,
      totalPriceofGreyscalePages: totalPriceofGreyscalePages ?? this.totalPriceofGreyscalePages
    );
  }
  
  @override
  List<Object> get props => [
    colorfulPagePrice,
    documentID,
    errorMessage,
    filename,
    filePath,
    fileSelected,
    grandTotalPrice,
    greyscalePagePrice,
    iconSubmitButton,
    isSnackBarShowedUp,
    isSubmitButtonDisabled,
    textSubmitButton,
    totalColorfulPages,
    totalGreyscalePages,
    totalPriceofColorfulPages,
    totalPriceofGreyscalePages
  ];
}
