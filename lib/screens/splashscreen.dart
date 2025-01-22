import 'package:flutter/material.dart';

// Define a new widget for the splash screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Define a custom turquoise color
  static const Color turquoise = Color(0xFF40E0D0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: turquoise, // Use the custom turquoise color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered image filling the width
            Expanded(
              child: Image.asset(
                'lib/assets/images/logo.png', // Update with your image path
                fit: BoxFit.contain, // Adjust to fit the screen width
              ),
            ),
            const SizedBox(height: 20),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
