import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_list_states.dart';

class CartListCubit extends HydratedCubit<CartListState> {
  CartListCubit() : super(const CartListLoaded({}));

  void addProduct(Map<String, dynamic> product) {
    final currentProducts =
        Map<String, Map<String, dynamic>>.from(state.products);
    final productName = product['name'];

    if (currentProducts.containsKey(productName)) {
      currentProducts[productName]!['quantity']++;
    } else {
      product['quantity'] = 1;
      currentProducts[productName] = product;
    }

    emit(CartListLoaded(currentProducts));
  }

  void clearCart() {
    emit(const CartListLoaded({})); // Emit an empty cart state
  }

  Map<String, Map<String, dynamic>> getProductsInCart() {
    return Map<String, Map<String, dynamic>>.from(state.products);
  }

  void deleteProduct(String productName, {bool deleteCompletely = false}) {
    final currentProducts =
        Map<String, Map<String, dynamic>>.from(state.products);

    if (currentProducts.containsKey(productName)) {
      if (deleteCompletely) {
        currentProducts.remove(productName);
      } else {
        final currentQuantity = currentProducts[productName]!['quantity'];
        if (currentQuantity > 1) {
          currentProducts[productName]!['quantity']--;
        } else {
          currentProducts.remove(productName);
        }
      }
    }

    emit(CartListLoaded(currentProducts));
  }

  double calculateTotalPrice() {
    return state.products.values.fold(0.0, (total, product) {
      final quantity = product['quantity'] as int;
      final price = product['price'] as double;
      return total + (quantity * price);
    });
  }

  @override
  CartListState? fromJson(Map<String, dynamic> json) =>
      CartListState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CartListState state) => state.toJson();
}
