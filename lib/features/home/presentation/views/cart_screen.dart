import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/helpers/showSnackBar.dart';
import 'package:electronics_shop/features/home/presentation/view_models/cart_list_cubit/cart_list_cubit.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:electronics_shop/features/home/presentation/views/widgets/place_order_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kSecondaryColor,
      body: BlocBuilder<CartListCubit, CartListState>(
        builder: (context, state) {
          final totalPrice =
              context.read<CartListCubit>().calculateTotalPrice();
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final productName = state.products.keys.elementAt(index);
                      final product = state.products[productName]!;
                      final quantity = product['quantity'];
                      return Dismissible(
                        key: Key(productName),
                        background: Container(
                          color: Colors.red,
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<CartListCubit>().deleteProduct(
                              productName,
                              deleteCompletely: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: Constants.kTritaryColor,
                            child: ListTile(
                              title: Text(
                                '$productName x$quantity',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '\$${(product['price'] * quantity as double).toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context
                                      .read<CartListCubit>()
                                      .deleteProduct(productName);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.products.length,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total : \$${totalPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  text: "Place Order",
                  callback: () {
                    if (context
                        .read<CartListCubit>()
                        .getProductsInCart()
                        .isNotEmpty) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        builder: (context) => const PlaceOrderBottomSheet(),
                      );
                    } else {
                      showSnackBar(context, "Cart is empty");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
