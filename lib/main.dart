import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 251, 231, 239),
        fontFamily: 'ComingSoon',
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: Color.fromARGB(202, 105, 48, 23),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(180, 211, 156, 129),
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(203, 84, 38, 18),
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
        ),
        textTheme: const TextTheme(bodyText2: TextStyle()).apply(
          bodyColor: const Color.fromARGB(203, 84, 38, 18),
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
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(202, 224, 44, 125)),
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
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
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
