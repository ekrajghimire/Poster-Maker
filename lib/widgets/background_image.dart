import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;

  const BackgroundImage({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.90, // 90% of screen width
            height: MediaQuery.of(context).size.height *
                0.85, // 85% of screen height
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.backgroundImage),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
