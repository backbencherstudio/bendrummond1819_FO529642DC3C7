import 'package:firebase_auth/firebase_auth.dart';
import 'apple_auth_service.dart';
import 'firebase_bootstrap.dart';
import 'google_auth_service.dart';

class FirebaseServices {
  FirebaseServices._();

  static Future<void> initialize() => FirebaseBootstrap.initialize();

  static Future<UserCredential?> signInWithGoogle() =>
      GoogleAuthService.signIn();

  static Future<UserCredential> signInWithApple() => AppleAuthService.signIn();

  static Future<String?> getIdToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return user.getIdToken();
  }

  static Future<void> signOut() async {
    await GoogleAuthService.signOut();
    await FirebaseAuth.instance.signOut();
  }
}

