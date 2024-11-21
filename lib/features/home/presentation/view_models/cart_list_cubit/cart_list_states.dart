part of 'cart_list_cubit.dart';

@immutable
abstract class CartListState {
  final Map<String, Map<String, dynamic>> products;

  const CartListState(this.products);

  Map<String, dynamic> toJson();
  static CartListState fromJson(Map<String, dynamic> json) => CartListLoaded(
      Map<String, Map<String, dynamic>>.from(json['products'] ?? {}));
}

class CartListLoaded extends CartListState {
  // ignore: use_super_parameters
  const CartListLoaded(Map<String, Map<String, dynamic>> products)
      : super(products);

  @override
  Map<String, dynamic> toJson() => {'products': products};
}
