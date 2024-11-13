 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthManager {
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (error) {
      print("Google sign-in/sign-up failed: $error");
      return null;
    }
  }

  Future<User?> signInAnonymous() async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Anonymous signin failed: $e');
      return null;
    }
  }

  Future<void> signOut() async => await FirebaseAuth.instance.signOut();
}
