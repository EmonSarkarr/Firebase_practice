import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_firestore_test/screen/add_post_page.dart';
import 'package:firebase_firestore_test/screen/homepage.dart';
import 'package:firebase_firestore_test/screen/login_page.dart';
import 'package:firebase_firestore_test/screen/register_page.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Firebase',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
     initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) =>const HomePage(),
        AddPostPage.routeName : (context) => const AddPostPage(),
        LoginPage.routeName : (context) => const LoginPage(),
        RegisterPage.routeName : (context) => const RegisterPage(),
      },
    );
  }
}
