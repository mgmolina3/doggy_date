import 'package:flutter/services.dart';

import 'profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _submitted = false;

  // Login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      }
    }
    return user;
  }

  String? get _errorTextEmail {
    final text = _emailController.value.text;

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  String? get _errorTextPassword {
    final text = _passwordController.value.text;

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/image/logo.png',
              alignment: Alignment.topCenter,
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ValueListenableBuilder(
              valueListenable: _emailController,
              builder: (context, TextEditingValue value, __) {
                return TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "User Email",
                    errorText: _submitted ? _errorTextEmail : null,
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Color.fromARGB(202, 53, 24, 12),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            ValueListenableBuilder(
              valueListenable: _passwordController,
              builder: (context, TextEditingValue value, __) {
                return TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "User Password",
                    errorText: _submitted ? _errorTextPassword : null,
                    prefixIcon: const Icon(
                      Icons.security,
                      color: Color.fromARGB(202, 53, 24, 12),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: (() => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()))),
                  child: const Text(
                    " Create account",
                    style: TextStyle(
                      color: Color.fromARGB(204, 244, 60, 127),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() => _submitted = true);
                  if (_emailController.value.text.isNotEmpty) {
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    }
                  } else {
                    print('invalid');
                  }
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
