import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_firestore_test/screen/add_post_page.dart';
import 'package:firebase_firestore_test/screen/login_page.dart';
import 'package:firebase_firestore_test/screen/register_page.dart';
import 'package:firebase_firestore_test/util/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getAllStudentsInfo =
      FirebaseFirestore.instance.collection('students').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){

            Navigator.pushNamed(context, LoginPage.routeName);
          }, icon: const Icon(Icons.login)),
          IconButton(onPressed: (){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
          }, icon: const Icon(Icons.app_registration)),
          IconButton(onPressed: (){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getAllStudentsInfo,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return const Text("Error ::) ");
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){

                return ListTile(
                  leading: CircleAvatar(child: Text(snapshot.data!.docs[index]['roll'].toString())),
                  title: Text(snapshot.data!.docs[index]['name'].toString()),
                  subtitle: Text(' Department: ${snapshot.data!.docs[index]['department'].toString()}'),

                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPostPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
