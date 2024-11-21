import 'package:electronics_shop/features/home/presentation/views/widgets/place_order_form.dart';
import 'package:flutter/material.dart';

class PlaceOrderBottomSheet extends StatelessWidget {
  const PlaceOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: const SingleChildScrollView(
        child: PlaceOrderForm(),
      ),
    );
  }
}
