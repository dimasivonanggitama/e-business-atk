import 'package:ebusiness_atk_mobile/models/cart_model.dart';
import '/models/database_services.dart';

abstract class CartRepositoryAbstract {
  Future<List<CartModel>> retrieveUserCart(String productID, String userID);
  set saveProduct(CartModel selectedProduct);
}

class CartRepository implements CartRepositoryAbstract {
  DatabaseServices service = DatabaseServices();

  @override
  Future<List<CartModel>> retrieveUserCart(String productID, String userID) {
    return service.getUserCart(productID, userID);
  }

  set saveProduct(CartModel submittedProduct) {
    service.addCart = submittedProduct;
  }
}