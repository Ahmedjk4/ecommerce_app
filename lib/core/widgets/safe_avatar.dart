import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

class SafeAvatar extends StatelessWidget {
  final String? displayName; // The display name of the user
  final Widget errorWidget; // Widget to show if there's an error

  const SafeAvatar({
    super.key,
    required this.displayName,
    required this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // Check if displayName is null or empty
    if (displayName == null || displayName!.isEmpty) {
      return errorWidget; // Return the error widget if there's an issue
    }

    // Display the avatar with the provided name
    return Avatar(
      name: displayName!,
      useCache: true,
    );
  }
}
