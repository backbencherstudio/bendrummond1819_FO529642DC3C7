import 'dart:convert';
import 'dart:math';

import 'package:bendrummond1819_fo529642dc3c7/firebase_options.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthService {
  AppleAuthService._();

  static const String _serviceId = 'com.innova.stabilityapp.signin';
  static const String _redirectUri =
      'https://stability-e6ac3.firebaseapp.com/__/auth/handler';

  static Future<UserCredential> signIn() async {
    final rawNonce = _generateNonce();
    final hashedNonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: _serviceId,
        redirectUri: Uri.parse(_redirectUri),
      ),
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: appleCredential.authorizationCode,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      oauthCredential,
    );

    if (appleCredential.givenName != null) {
      await userCredential.user?.updateDisplayName(
        '${appleCredential.givenName} ${appleCredential.familyName}',
      );
    }

    return userCredential;
  }

  //********* Helper Methods**********
  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  static String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
