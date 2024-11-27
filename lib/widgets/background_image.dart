import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;

  const BackgroundImage({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}