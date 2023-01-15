import '../../models/productCategory_model.dart';
import '../../models/product_model.dart';
import '../../repository/product_repository.dart';

Future convertCategoryIDtoName(List listofProducts) async {
  final ProductRepository _databaseRepository = ProductRepository();
  List<ProductCategoryModel> listofProductCategory = await _databaseRepository.retrieveCategories();
  for(int i = 0; i < listofProducts.length; i++) {
    for(int j = 0; j < listofProductCategory.length; j++) {
      if (listofProducts[i].category == listofProductCategory[j].id) listofProducts[i].category = listofProductCategory[j].category;
    }
  }
  return listofProducts;
}