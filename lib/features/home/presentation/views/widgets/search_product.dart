import 'package:electronics_shop/features/home/presentation/view_models/products_filter_cubit/products_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF454D5A),
        borderRadius: BorderRadius.circular(14),
      ),
      height: 50,
      width: 310,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: false,
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  BlocProvider.of<ProductsFilterCubit>(context)
                      .searchProduct(value);
                },
                onChanged: (value) {
                  BlocProvider.of<ProductsFilterCubit>(context)
                      .searchProduct(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products ...",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Icon(Icons.search, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
