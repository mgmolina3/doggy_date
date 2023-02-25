import 'package:doggy_date/utils/custom_colors.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/alerts.dart';
import '../utils/errors.dart';
import 'home_screen.dart';
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
  bool _isProcessing = false;

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
              height: 25,
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
                    prefixIcon: Icon(
                      Icons.mail,
                      color: iconDarkGray,
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
                    prefixIcon: Icon(
                      Icons.security,
                      color: iconDarkGray,
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
                  style: TextStyle(fontSize: 18.0),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: RegisterScreen(),
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: LoginScreen(),
                    ),
                  ),
                  child: Text(
                    " Create one now!",
                    style: TextStyle(
                      color: pinkText,
                      fontSize: 18.0,
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
                  if (_emailController.value.text.isNotEmpty &&
                      _passwordController.value.text.isNotEmpty) {
                    try {
                      setState(() => _isProcessing = true);
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                      setState(() => _isProcessing = false);
                      if (credential.user != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      String errorMsg = handleAuthError(e);
                      await showErrorAlert(context, errorMsg);
                      setState(() => _isProcessing = false);
                    } catch (e) {
                      await showErrorAlert(context, defaultErrorMsg);
                      print(e);
                      setState(() => _isProcessing = false);
                    }
                  }
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              height: 40.0,
              width: 40.0,
              child: _isProcessing ? const CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }
}
