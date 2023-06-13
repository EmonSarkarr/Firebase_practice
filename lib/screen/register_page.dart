import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_firestore_test/screen/homepage.dart';
import 'package:firebase_firestore_test/util/utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String routeName = '/registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

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
                child: Text('Register',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold))),
            const Center(
                child: Text('Create a new user',
                    style: TextStyle(fontSize: 30, color: Colors.greenAccent))),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email must not be empty';
                  } else {
                    return null;
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
                    return 'password must not be empty';
                  }
                  if (value.length < 8) {
                    return 'Password should be 8 character';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    fillColor: Colors.brown,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                    hintText: 'Create a new password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 80.0, right: 80.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (fromKey.currentState!.validate()) {
                      print('save button is working..... ');
                      register();
                      print('save button work is completed  ');
                    }
                  },
                  child: const Text('Register')),
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      Navigator.pushNamed(context, HomePage.routeName);
    }).onError((error, stackTrace) {
      Utils().showErrorMsgToast(error.toString());
    });
  }
}
