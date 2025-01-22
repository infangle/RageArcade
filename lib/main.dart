import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase package
import 'screens/splashscreen.dart'; // Import the SplashScreen class
import 'auth/signup.dart'; // Import the SignUpPage class
import 'auth/firebase_credentials.dart'; // Import Firebase credentials

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure the Flutter binding is initialized
  await Firebase.initializeApp(
    options: FirebaseCredentials.options, // Pass FirebaseOptions here
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Rage Arcade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreenWrapper(), // Splash screen as the starting page
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateToSignUp();
  }

  // Navigate to SignUpPage after the splash screen
  void _navigateToSignUp() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash screen duration
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(); // Display the splash screen
  }
}
