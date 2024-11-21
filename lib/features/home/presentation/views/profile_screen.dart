import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/helpers/showPrompt.dart';
import 'package:electronics_shop/core/services/change_name_service.dart';
import 'package:electronics_shop/core/services/logout_user_service.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:electronics_shop/core/widgets/safe_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kTritaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeAvatar(
                displayName: FirebaseAuth.instance.currentUser!.displayName,
                errorWidget: const Icon(Icons.person)),
            const SizedBox(
              height: 20,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "Anonymous",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Change Name',
              callback: () async {
                final name = await showPrompt(
                  context,
                  title: const Text('Change Name'),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  backgroundColor: Constants.kSecondaryColor,
                );
                if (context.mounted && name != null) {
                  await ChangeNameService.changeName(context, name);
                  setState(() {});
                }
              },
            ),
            CustomButton(
              text: 'Logout',
              callback: () async {
                await LogoutUserService.logoutUser();
              },
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
