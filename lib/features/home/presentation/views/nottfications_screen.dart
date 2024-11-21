import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_shop/constants.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Constants.kSecondaryColor,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('notifications')
                  .doc('users')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Text("No Notifications");
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!['messages'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: const Key("NotificationsDismissableKey"),
                        direction: DismissDirection.endToStart,
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(
                            snapshot.data!['messages'][index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          tileColor: Colors.blue,
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
          // Center(
          //   child: Text(
          //     "No Notifications",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
