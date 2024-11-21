import 'package:electronics_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback callback;
  const SettingsButton({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.kSecondaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: callback,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              FontAwesomeIcons.sliders,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
