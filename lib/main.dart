import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'package:doggy_date/utils/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: homeBackground,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: iconDarkGray, size: 28),
          unselectedIconTheme: IconThemeData(color: grayText, size: 25),
          selectedItemColor: iconDarkGray,
          unselectedItemColor: grayText,
          selectedLabelStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'Kalam',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Kalam',
          ),
        ),
        scaffoldBackgroundColor: loginBackground,
        fontFamily: 'ComingSoon',
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: black,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: unfocusedBorderGray,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: black,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.redAccent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.redAccent,
            ),
          ),
          errorStyle: const TextStyle(fontSize: 12),
        ),
        textTheme: const TextTheme(bodyText2: TextStyle()).apply(
          bodyColor: black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 22.0,
                fontFamily: 'ComingSoon',
              ),
            ),
            backgroundColor: MaterialStateProperty.all(buttonGray),
            elevation: MaterialStateProperty.all(0.0),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: black,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize Firebase App

  Future<FirebaseApp?> _initializeFirebase() async {
    try {
      FirebaseApp firebaseApp = await Firebase.initializeApp(
        //options: DefaultFirebaseOptions.currentPlatform,
      );
      return firebaseApp;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
