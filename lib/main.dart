import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/signin_provider.dart';
import 'provider/movie_list_provider.dart';

import 'screens/login_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error Occucred"),
              ),
            ),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SignInProvider>(
                create: (_) => SignInProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => MovieListProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                primarySwatch: Colors.purple,
                textTheme: const TextTheme(
                  headline6: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: "JosefinSans",
                  ),
                  headline5: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "JosefinSans",
                  ),
                ),
              ),
              home: const LoginScreen(),
              routes: {
                ListScreen.routename: (ctx) => const ListScreen(),
                UploadScreen.routeName: (ctx) => const UploadScreen(),
                LoginScreen.routename:(ctx)=> const LoginScreen(),
              },
            ),
          );
        }
      },
      future: _initialization,
    );
  }
}
