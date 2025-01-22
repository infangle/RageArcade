import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_credentials.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseService() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    print("Initializing Firebase...");
    try {
      await Firebase.initializeApp(
        options: FirebaseCredentials.options, // Pass FirebaseOptions here
      );
      print("Firebase initialized successfully.");
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  Future<UserCredential> registerWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential; // Return the UserCredential
    } catch (e) {
      // Handle the error
      throw Exception('Registration failed: $e');
    }
  }
}
