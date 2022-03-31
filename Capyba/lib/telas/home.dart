import 'package:capyba/main.dart';
import 'package:capyba/model/ModeloUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capyba/telas/sideMenu.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  User? user = FirebaseAuth.instance.currentUser;
  ModeloUser loggedInUser = ModeloUser();
   
   @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = ModeloUser.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
    );
  }
}
