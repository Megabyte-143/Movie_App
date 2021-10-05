import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/google_signin_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routename = "/login_screen";
  @override
  Widget build(BuildContext context) {
    final signInProvider =
        Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  signInProvider.googleLogIn(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(152, 20, 255, 0.41),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: Offset.fromDirection(1, 4),
                        spreadRadius: 5,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "GOOGLE LOGIN",
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  signInProvider.logInAnonymously(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(152, 20, 255, 0.41),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: Offset.fromDirection(1, 4),
                        spreadRadius: 5,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In Anonymously",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
