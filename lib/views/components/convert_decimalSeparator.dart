String decimalSeparator(int price) {
  List<String> splittedCharacter = price.toString().split('');
  String priceWithSeparator = "";
  int j = 0;

  for (int i = splittedCharacter.length - 1; i >= 0; i--, j++) {
    if (j % 3 == 0 && j != 0) priceWithSeparator = splittedCharacter[i] + "." + priceWithSeparator;
    else priceWithSeparator = splittedCharacter[i] + priceWithSeparator;
  }
  
  return priceWithSeparator;
}