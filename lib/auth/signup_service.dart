import 'package:flutter/material.dart';

class SignUpService {
  // Method to validate signup input
  String? validateInput(
      String username, String email, String password, String confirmPassword) {
    if (username.isEmpty) {
      return 'Please enter your username';
    }
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null; // No errors
  }
}