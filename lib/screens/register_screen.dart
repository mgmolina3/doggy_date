import 'package:doggy_date/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_profile_screen.dart';
import 'login_screen.dart';
import '../utils/alerts.dart';
import '../utils/errors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _submitted = false;
  bool _isProcessing = false;

  // Login function
  static Future<User?> registerUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("error $e");
    }
    return user;
  }

  String? get _errorTextEmail {
    final text = _emailController.value.text;

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    if (!EmailValidator.validate(text)) {
      return 'Invalid email format.';
    }

    return null;
  }

  String? get _errorTextPassword {
    final text = _passwordController.value.text;
    RegExp number = RegExp(r'\d+');
    RegExp specialChar = RegExp(r'(@|#|!)+');

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }

    if (text.length < 6) {
      return 'Password should be at least 6 characters long.';
    }

    if (!number.hasMatch(text)) {
      return 'Password should contain at least one number.';
    }

    if (!specialChar.hasMatch(text)) {
      return 'Password should contain at least one special character (!,@, or #)';
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
                "Create your free account!",
                style: TextStyle(
                  fontSize: 30.0,
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
                    hintText: "Your Email",
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
                    hintText: "Create a Password",
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
                  "Already have an account?",
                  style: TextStyle(fontSize: 18.0),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: LoginScreen(),
                      type: PageTransitionType.leftToRightJoined,
                      childCurrent: RegisterScreen(),
                    ),
                  ),
                  child: Text(
                    " Login here!",
                    style: TextStyle(
                      color: pinkText,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() => _submitted = true);
                  if (_emailController.value.text.isNotEmpty &&
                      _passwordController.value.text.isNotEmpty &&
                      _errorTextEmail == null &&
                      _errorTextPassword == null) {
                    try {
                      setState(() => _isProcessing = true);
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      setState(() => _isProcessing = false);
                      if (credential.user != null) {
                        await showSuccessAlert(
                            context, 'Successfully created your account.');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateProfileScreen()));
                      }
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      String errorMsg = handleAuthError(e);
                      await showErrorAlert(context, errorMsg);
                      setState(() => _isProcessing = false);
                    } catch (e) {
                      await showErrorAlert(context, defaultErrorMsg);
                      setState(() => _isProcessing = false);
                      print(e);
                    }
                  }
                },
                child: const Text(
                  'Create Account',
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
