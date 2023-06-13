import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_test/screen/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  static const String routeName = 'addPostPage';

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late Size size;
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _studentNameController.dispose();
    _classController.dispose();
    _departmentController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Add a post '), centerTitle: true),
      body: Form(
        key: formkey,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('lib/image/student.jpg',
                  height: size.height / 3.5,
                  width: size.width / 1,
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This filled must not empty';
                  }
                },
                controller: _studentNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: const Icon(Icons.drive_file_rename_outline),
                    filled: true,
                    labelText: 'Student Name',
                    hintText: 'Enter Student name,'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This filled must not empty';
                  } else {
                    return null;
                  }
                },
                controller: _classController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: const Icon(Icons.class_),
                    filled: true,
                    labelText: 'Class',
                    hintText: 'Enter Student class'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This filled must not empty';
                  } else {
                    return null;
                  }
                },
                controller: _departmentController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: const Icon(Icons.local_fire_department),
                    filled: true,
                    labelText: 'Department',
                    hintText: 'Enter Student Department'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This filled must not empty';
                  } else {
                    return null;
                  }
                },
                controller: _rollNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: const Icon(Icons.numbers),
                    filled: true,
                    labelText: 'RollNumber',
                    hintText: 'Enter Student RollNumber'),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {

                      Map<String, dynamic> studentInfo = {
                        'name': _studentNameController.text,
                        'department': _departmentController.text,
                        'class': _classController.text,
                        'roll': _rollNumberController.text,
                      };
                      FirebaseFirestore.instance
                          .collection('students')
                          .add(studentInfo);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()));
                      // Navigator.pushNamed(context, HomePage.routeName);
                      print('save button work is completed  ');
                    }
                  },
                  child: const Text('SAVE')),
            )
          ],
        ),
      ),
    );
  }
}
