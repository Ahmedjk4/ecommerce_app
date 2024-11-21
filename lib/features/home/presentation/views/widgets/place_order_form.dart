import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_shop/core/helpers/showPrompt.dart';
import 'package:electronics_shop/core/helpers/showSnackBar.dart';
import 'package:electronics_shop/core/services/place_order_service.dart';
import 'package:electronics_shop/core/utils/types/text_form_field_types.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:electronics_shop/core/widgets/custom_text_form_field.dart';
import 'package:electronics_shop/features/home/presentation/view_models/cart_list_cubit/cart_list_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderForm extends StatefulWidget {
  const PlaceOrderForm({super.key});

  @override
  State<PlaceOrderForm> createState() => _PlaceOrderFormState();
}

class _PlaceOrderFormState extends State<PlaceOrderForm> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // Check if user information needs to be updated
          if (data['updatedInfo'] == false) {
            return _UpdateUserDetailsForm(
              formKey: formKey,
              fullNameController: fullNameController,
              phoneNumberController: phoneNumberController,
              cityController: cityController,
              addressController: addressController,
              autoValidateMode: autoValidateMode,
              onPlaceOrder: () async {
                await _handlePlaceOrder(context);
              },
            );
          } else {
            return _ReadyToPlaceOrder(
              formKey: formKey,
              onPlaceOrder: () async {
                // Update user info in Firestore

                await _handlePlaceOrder(context);
              },
              userData: {
                'fullName': data['fullName'],
                'phoneNumber': data['phoneNumber'],
                'city': data['city'],
                'address': data['address'],
              },
            );
          }
        }
        return const Center(child: Text("Document does not exist"));
      },
    );
  }

  Future<void> _handlePlaceOrder(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // Update user info in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'fullName': fullNameController.text,
        'phoneNumber': phoneNumberController.text,
        'city': cityController.text,
        'address': addressController.text,
        'updatedInfo': true,
      });

      // Prompt user to confirm order
      if (context.mounted) {
        showPrompt(
          context,
          title: const Text("Confirm Order?"),
          textOK: const Text("Confirm"),
          textCancel: const Text("Cancel"),
          showTextField: false,
          onPopInvoked: (confirm) async {
            if (confirm == true) {
              await PlaceOrderService.placeOrder(
                context,
                totalPrice: context.read<CartListCubit>().calculateTotalPrice(),
                order: context.read<CartListCubit>().getProductsInCart(),
              );

              if (context.mounted) {
                context.read<CartListCubit>().clearCart();
                showSnackBar(context, "Order Placed");
                context.pop();
              }
            } else if (confirm == false) {
              if (context.mounted) {
                context.pop();
              }
            }
          },
        );
      }
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }
}

class _UpdateUserDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final AutovalidateMode autoValidateMode;
  final Future<void> Function() onPlaceOrder;

  const _UpdateUserDetailsForm({
    required this.formKey,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.cityController,
    required this.addressController,
    required this.autoValidateMode,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Hello ${fullNameController.text.isEmpty ? 'User' : fullNameController.text}',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Please update your profile information',
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            hintText: 'Full Name',
            label: 'Full Name',
            controller: fullNameController,
            type: TextFormFieldTypes.name,
          ),
          _buildTextField(
            hintText: 'Phone Number With WhatsApp',
            label: 'Phone Number',
            controller: phoneNumberController,
            type: TextFormFieldTypes.number,
          ),
          _buildTextField(
            hintText: 'City Name',
            label: 'City',
            controller: cityController,
            type: TextFormFieldTypes.name,
          ),
          _buildTextField(
            hintText: 'Your Address',
            label: 'Address',
            controller: addressController,
            type: TextFormFieldTypes.name,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Place Order',
            callback: onPlaceOrder,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required String label,
    required TextEditingController controller,
    required TextFormFieldTypes type,
  }) {
    return CustomTextField(
      hintText: hintText,
      label: label,
      controller: controller,
      type: type,
    );
  }
}

class _ReadyToPlaceOrder extends StatefulWidget {
  final Future<void> Function() onPlaceOrder;
  final Map<String, dynamic> userData; // To hold existing user data
  final GlobalKey<FormState> formKey;
  const _ReadyToPlaceOrder({
    required this.onPlaceOrder,
    required this.userData,
    required this.formKey,
  });

  @override
  __ReadyToPlaceOrderState createState() => __ReadyToPlaceOrderState();
}

class __ReadyToPlaceOrderState extends State<_ReadyToPlaceOrder> {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    fullNameController =
        TextEditingController(text: widget.userData['fullName']);
    phoneNumberController =
        TextEditingController(text: widget.userData['phoneNumber']);
    addressController = TextEditingController(text: widget.userData['address']);
    cityController = TextEditingController(text: widget.userData['city']);
  }

  @override
  void dispose() {
    // Dispose of controllers to free up resources
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ready to place order'),
              const SizedBox(height: 20),
              _buildTextField(
                hintText: 'Full Name',
                label: 'Full Name',
                controller: fullNameController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hintText: 'Phone Number With WhatsApp',
                label: 'Phone Number',
                controller: phoneNumberController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hintText: 'City Name',
                label: 'City',
                controller: cityController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hintText: 'Your Address',
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Update user info before placing the order
                  await widget.onPlaceOrder();
                },
                child: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _updateUserInfo() async {
    // Update user info in Firestore with edited values
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'fullName': fullNameController.text,
      'phoneNumber': phoneNumberController.text,
      'city': cityController.text,
      'address': addressController.text,
      'updatedInfo': true, // You may want to keep this as true
    });
  }
}
