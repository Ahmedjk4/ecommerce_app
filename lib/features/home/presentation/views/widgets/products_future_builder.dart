import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_shop/core/utils/app_router.dart';
import 'package:electronics_shop/features/home/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsFutureBuilder extends StatelessWidget {
  const ProductsFutureBuilder({
    super.key,
    required this.products,
    required this.category,
    required this.searchText,
  });

  final CollectionReference<Object?> products;
  final String category;
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: products.doc(category).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.hasData) {
          List<dynamic> products = snapshot.data!['products'];
          // var searchText = HomeScreen._searchController.text;
          List<dynamic> filteredProductsBySearch = products.where((product) {
            return product["name"]!
                .toLowerCase()
                .contains(searchText.toLowerCase());
          }).toList();
          return CarouselSlider.builder(
            itemBuilder: (context, index, _) {
              return GestureDetector(
                onTap: () {
                  context.push(AppRouter.product,
                      extra: filteredProductsBySearch[index]);
                },
                child: ProductCard(
                  snapshot: filteredProductsBySearch[index],
                ),
              );
            },
            options: CarouselOptions(
                height: 450,
                enableInfiniteScroll: false,
                aspectRatio: 0.8,
                pageSnapping: true,
                enlargeCenterPage: true,
                padEnds: false),
            itemCount: filteredProductsBySearch.length,
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
