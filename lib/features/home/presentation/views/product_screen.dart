import 'package:cached_network_image/cached_network_image.dart';
import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/features/home/presentation/view_models/cart_list_cubit/cart_list_cubit.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
  final Map<String, dynamic> product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Hero(
              tag: product['image'],
              child: SizedBox(
                height: 400,
                width: 600,
                child: CachedNetworkImage(
                  imageUrl: product['image'],
                ),
              ),
            ),
            const Row(children: <Widget>[
              Expanded(child: Divider()),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Text(
                  product["name"],
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product["description"] ?? "No Description",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            CustomButton(
              text: "Add To Cart",
              callback: () {
                BlocProvider.of<CartListCubit>(context).addProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${product["name"]} added to cart"),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
