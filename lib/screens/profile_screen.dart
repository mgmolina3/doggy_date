import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  //String? username = user.displayName;

  @override
  Widget build(BuildContext context) {
    String email = user!.email!;

    return Scaffold(
      body: Center(
        child: Text("Welcome to your profile page $email"),
      ),
    );
  }
}
