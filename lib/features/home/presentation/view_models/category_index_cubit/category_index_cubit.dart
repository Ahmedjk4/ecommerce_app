import 'package:bloc/bloc.dart';

class CategoryIndexCubit extends Cubit<String> {
  CategoryIndexCubit() : super('all');
  void setCategoryTo(String index) {
    emit(index);
  }
}
