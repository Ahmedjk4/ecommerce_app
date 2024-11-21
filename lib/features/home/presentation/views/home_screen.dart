import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/features/home/presentation/view_models/category_index_cubit/category_index_cubit.dart';
import 'package:electronics_shop/features/home/presentation/view_models/products_filter_cubit/products_filter_cubit.dart';
import 'package:electronics_shop/features/home/presentation/views/widgets/horizontal_categories_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/products_future_builder.dart';
import 'widgets/search_product.dart';
import 'widgets/settings_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = "/homeScreen";
  final List<String> categories = const [
    'All',
    'Mobile Phones',
    'PCs',
    'Laptops',
    'PC Components',
    'Gaming Consoles',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('categories');

    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 19.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              HorizontalCategoriesSlider(categories: categories),
              Row(
                children: [
                  const SearchProduct(),
                  //List<String> matchingFruits = fruits.where((fruit) => fruit.contains(partialMatch)).toList();
                  const SizedBox(
                    width: 15,
                  ),
                  SettingsButton(
                    callback: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("TODO: Filter Settings"),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<CategoryIndexCubit, String>(
                builder: (context, state) {
                  return BlocBuilder<ProductsFilterCubit, String>(
                    builder: (context, searchState) {
                      return ProductsFutureBuilder(
                        products: products,
                        category: state,
                        searchText: searchState,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        enableFeedback: true,
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.bars,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.bell,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
