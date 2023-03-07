import 'package:doggy_date/utils/custom_colors.dart';
import 'package:doggy_date/utils/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _dogNameController = TextEditingController();
  String dogSexValue = 'Male';

  List<String> sexDropDown = [
    'Male',
    'Female',
  ];

  @override
  void dispose() {
    _dogNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
        backgroundColor: homeBackground,
      ),
      backgroundColor: white,
      body:
          Column(), /*Column(
        children: [
          const Text(
            "Welcome to Doggy Date, where our goal is to find your furry friend a mate!",
            style: TextStyle(fontSize: 15),
          ),
          const Text(
              "But first, let's get you setup by creating your profile."),
          ValueListenableBuilder(
            valueListenable: _ownerNameController,
            builder: (context, TextEditingValue value, __) {
              return TextField(
                controller: _ownerNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Your name",
                  //errorText: _submitted ? _errorTextEmail : null,
                  prefixIcon: Icon(
                    Icons.person,
                    color: iconDarkGray,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 15.0),
          ValueListenableBuilder(
            valueListenable: _dogNameController,
            builder: (context, TextEditingValue value, __) {
              return TextField(
                controller: _dogNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Name of Your Dog",
                  //errorText: _submitted ? _errorTextEmail : null,
                  prefixIcon: Icon(
                    CustomIcons.dog,
                    color: iconDarkGray,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 15.0),
          const Text('Sex of your Dog:'),
          DropdownButton(
            value: dogSexValue,
            items: sexDropDown.map(
              (String sexDropDown) {
                return DropdownMenuItem(
                  value: sexDropDown,
                  child: Text(sexDropDown),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dogSexValue = newValue!;
                },
              );
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                //setState(() => _submitted = true);
                if (_ownerNameController.value.text.isNotEmpty &&
                    _dogNameController.value.text.isNotEmpty) {
                  try {
                    //setState(() => _isProcessing = true);
                    final user = {
                      "ownerName": _ownerNameController.value.text,
                      "dogName": _dogNameController.value.text,
                      "dogSex": dogSexValue
                    };

                    //setState(() => _isProcessing = false);
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
        ],
      ),*/
    );
  }
}
