import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/utils/app_router.dart';
import 'package:electronics_shop/features/home/presentation/views/cart_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/home_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/profile_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  static const String id = "/homePageView";

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.kPrimaryColor,
      appBar: customAppBar(context),
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            CustomBottomNavBar.selectedIndex = value;
          });
        },
        children: const [
          HomeScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}

AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leadingWidth: 120,
    leading: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16),
      child: Text(
        "CStore",
        style: GoogleFonts.poppins(
            color: Constants.kTritaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          context.push(AppRouter.notifications);
        },
        icon: const Icon(
          FontAwesomeIcons.bell,
          color: Colors.white,
        ),
      ),
    ],
  );
}
