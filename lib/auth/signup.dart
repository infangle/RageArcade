import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String confirmPassword = '';
  String username = '';

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _signUpWithEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (!userDoc.exists) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': email,
            'username': username.isEmpty ? null : username,
            'highestScore': 0,
          });
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (!userDoc.exists) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': userCredential.user!.email,
            'username': userCredential.user!.displayName ?? '',
            'highestScore': 0,
          });
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  confirmPassword = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Username (Optional)'),
                onChanged: (value) {
                  username = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUpWithEmail,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: const Icon(Icons.login),
                label: const Text('Sign Up with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
