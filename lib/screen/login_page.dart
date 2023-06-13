import 'package:firebase_firestore_test/screen/homepage.dart';
import 'package:firebase_firestore_test/screen/register_page.dart';
import 'package:firebase_firestore_test/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/round_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  final _currentUser = FirebaseAuth.instance.currentUser!.email!;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fromKey,
        child: ListView(
          children: [
            const Center(
                child: Text('LOGIN',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold))),
            const Center(
                child: Text('Welcome to Firebase',
                    style: TextStyle(fontSize: 30, color: Colors.greenAccent))),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 50, bottom: 10, right: 20),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please give your email and Password';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    fillColor: Colors.brown,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Enter your Email or phone Number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password Must not be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    fillColor: Colors.brown,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Enter your Email or phone Number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80,right: 80.0,top: 10),
              child: RoundButton(

                title: 'LOGIN',
                onTap: () {
                  if (fromKey.currentState!.validate()) {
                    logIn();
                  }
                },
                loading: isLoading,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Are you new here create a new account'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.routeName);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void logIn() async {
    setState(() {
      isLoading = true;
    });
    await _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>const HomePage()));
      setState(() {
        isLoading = false;
      });
      Utils().showSuccessMsgToast('Login as: ${_currentUser.toString()}');

    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      Utils().showErrorMsgToast(error.toString());
    });
  }
}
