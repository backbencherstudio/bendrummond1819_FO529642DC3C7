import 'package:bendrummond1819_fo529642dc3c7/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseBootstrap {
  FirebaseBootstrap._();

  static const String _googleServerClientId =
      '160078582396-r5md49isqvgs33eqphreiopvs53fi85v.apps.googleusercontent.com';

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GoogleSignIn.instance.initialize(
      serverClientId: _googleServerClientId,
    );
  }
}
