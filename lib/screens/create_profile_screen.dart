import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  //String? username = user.displayName;

  @override
  Widget build(BuildContext context) {
    String email = user!.email!;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Welcome to your profile page $email"),
      ),
    );
  }
}
