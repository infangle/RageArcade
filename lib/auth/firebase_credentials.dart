import 'package:firebase_core/firebase_core.dart';

class FirebaseCredentials {
  static const String senderId = '566260733153';
  static const String apiKey = 'AIzaSyBZtqnA_0zmjesDjoFafETvPeS8EDbyLqI';
  static const String projectId = 'ragearcade-4fa14';
  static const String appId = '1:566260733153:android:600cbd7de59a299e6753a0';
  static const String messagingSenderId = '566260733153';

  static FirebaseOptions get options => FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
      );
}
