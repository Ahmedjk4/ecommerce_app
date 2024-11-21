import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:electronics_shop/constants.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  static int selectedIndex = 0;
  final PageController controller;
  const CustomBottomNavBar({super.key, required this.controller});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      shadowColor: const Color(0xFF333742),
      selectedIndex: CustomBottomNavBar.selectedIndex,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      backgroundColor: Colors.transparent,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(19),
        topRight: Radius.circular(19),
      ),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            activeColor: const Color.fromARGB(255, 23, 23, 24),
            icon: Icon(
              CustomBottomNavBar.selectedIndex == 0
                  ? Icons.home
                  : Icons.home_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'HOME',
              style: TextStyle(color: Colors.white),
            )),
        BottomNavyBarItem(
          activeColor: const Color.fromARGB(255, 23, 23, 24),
          icon: Icon(
            CustomBottomNavBar.selectedIndex == 1
                ? Icons.shopping_bag
                : Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          title: const Text(
            'CART',
            style: TextStyle(color: Colors.white),
          ),
        ),
        BottomNavyBarItem(
          activeColor: const Color.fromARGB(255, 23, 23, 24),
          icon: Icon(
            CustomBottomNavBar.selectedIndex == 2
                ? Icons.person
                : Icons.person_outline,
            color: Colors.white,
          ),
          title: const Text(
            'PROFILE',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onItemSelected: (index) {
        setState(() {
          CustomBottomNavBar.selectedIndex = index;
          widget.controller.jumpToPage(index);
        });
      },
    );
  }
}
