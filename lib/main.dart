import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_list_provider.dart';
import 'package:provider/provider.dart';

import 'screens/upload_screen.dart';
import 'screens/list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
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
          return Provider(
            create: (_) => MovieListProvider(),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                primarySwatch: Colors.blue,
              ),
              home: ListScreen(),
              routes: {
                UploadScreen.routeName: (ctx) => const UploadScreen(),
              },
            ),
          );
        }
      },
      future: _initialization,
    );
  }
}
