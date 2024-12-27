import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstly/reusable_widgets/reusable_widget.dart';
import 'package:firstly/screens/signin_screen.dart';
import 'package:firstly/services/api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignUpScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController userFullnameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userBirthdateController = TextEditingController();
  TextEditingController userStudyProgramCodeController =
      TextEditingController();

  int calculateAge(String birthDateString) {
    if (birthDateString.isEmpty) {
      return 0;
    }
    DateTime birthDate = DateFormat("d MMMM yyyy").parse(birthDateString);

    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> pushDataToBackend() async {
    Map<String, dynamic> userData = {
      "email": userEmailController.text,
      "username": userFullnameController.text.toLowerCase(),
      "name": userFullnameController.text,
      "age": calculateAge(userBirthdateController.text),
      "score": 0,
      "profileImage": ""
    };

    await APIService.postData("/api/user", userData);
  }

  createData() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(userFullnameController.text);

    Map<String, dynamic> users = {
      "username": _userNameController.text,
      "email": _userEmailController.text,
      "fullName": userFullnameController.text,
      "birthDate": userBirthdateController.text,
      "studyProgramID": userStudyProgramCodeController.text
    };

    documentReference.set(users).whenComplete(() {
      String fname = userFullnameController.text;
      print("$fname created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.teal[200],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Username", Icons.person_outline, false,
                  _userNameController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email", Icons.person_outline, false,
                  _userEmailController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.person_outline, false,
                  _userPasswordController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Full Name", Icons.person_outline, false,
                  userFullnameController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Birth Date", Icons.person_outline, false,
                  userBirthdateController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Study Program", Icons.person_outline,
                  false, userStudyProgramCodeController),
              const SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, false, () async {
                createData();
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _userEmailController.text,
                        password: _userPasswordController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully registered')));
                }).onError((error, stackTrace) {
                  print("Error Connecting to Firebase ${error.toString()}");
                });
              })
            ]),
          ),
        ),
      ),
    );
  }
}
