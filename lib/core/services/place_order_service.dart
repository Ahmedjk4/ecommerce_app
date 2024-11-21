import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_shop/core/helpers/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlaceOrderService {
  static Future<void> placeOrder(BuildContext context,
      {required Map<String, Map<String, dynamic>> order,
      required double totalPrice}) async {
    if ((await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get())['updatedInfo'] ==
        false) {
      if (context.mounted) {
        showSnackBar(context,
            "Please update your information at profile page before placing the order");
        return;
      }
      return;
    }
    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    FirebaseFirestore.instance
        .collection("orders")
        .doc('order-${Random().nextInt(10000).toString()}')
        .set({
      "order": order,
      "orderDate": DateTime.now().toUtc(),
      "orderStatus": "Pending",
      "orderTotal": totalPrice,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "userName": userData['fullName'],
      "userEmail": FirebaseAuth.instance.currentUser!.email,
      "userPhoneNumber": userData['phoneNumber'],
      "userAddress": '${userData['city']} ${userData['address']}',
    });
  }
}
