import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsFilterCubit extends Cubit<String> {
  ProductsFilterCubit() : super("");
  void searchProduct(String index) {
    emit(index);
  }
}
