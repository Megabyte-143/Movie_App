import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/list_screen.dart';
import '../screens/login_screen.dart';

/// Provider contains all the functions of the Google SignIn Method
class SignInProvider extends ChangeNotifier {
  /// Initialization of the GoogleSignIn
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Function for LOGIN
  Future<void> googleLogIn(BuildContext context) async {
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await FirebaseAuth.instance
              .signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          )
              .then((UserCredential value) {
            Navigator.of(context).pushReplacementNamed(ListScreen.routename);
          });
        } catch (e) {
          AlertDialog(
            content: Text(
              e.toString(),
            ),
            title: const Text('An Error Occured'),
          );
        }
        notifyListeners();
      }
    }
  }

  Future<void> logInAnonymously(BuildContext context) async {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.of(context).pushReplacementNamed(ListScreen.routename);
  }

  /// Function for LOGOUT
  Future<void> logout(BuildContext context) async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routename);
  }
}
