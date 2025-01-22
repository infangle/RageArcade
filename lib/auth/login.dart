import 'package:flutter/material.dart';
import 'firebase_services.dart'; // Corrected import statement

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/images/google.png', // Updated to the correct asset name
                width: 24,
              ),
              onPressed: () {
                // Handle Google sign-in
              },
            ),
            // Other UI elements...
          ],
        ),
      ),
    );
  }
}
