import 'package:doggy_date/users/dog.dart';
import 'package:doggy_date/utils/alerts.dart';
import 'package:doggy_date/utils/custom_colors.dart';
import 'package:doggy_date/utils/errors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'create_dog_profile_screen.dart';

class CreateOwnerProfileScreen extends StatefulWidget {
  const CreateOwnerProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateOwnerProfileScreen> createState() =>
      _CreateOwnerProfileScreenState();
}

class _CreateOwnerProfileScreenState extends State<CreateOwnerProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  // OWNER INFORMATION
  final TextEditingController _ownerFirstNameController =
      TextEditingController();
  final TextEditingController _ownerLastNameController =
      TextEditingController();
  final TextEditingController _ownerDOBController = TextEditingController();
  final TextEditingController _ownerPhoneNumberController =
      TextEditingController();
  final TextEditingController _ownerAddressController = TextEditingController();
  final TextEditingController _ownerZipcodeController = TextEditingController();

  bool _submitted = false;
  bool _isProcessing = false;

  String? _errorText(TextEditingController controller) {
    final text = controller.value.text;

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  @override
  void dispose() {
    _ownerFirstNameController.dispose();
    _ownerLastNameController.dispose();
    _ownerDOBController.dispose();
    _ownerPhoneNumberController.dispose();
    _ownerAddressController.dispose();
    _ownerZipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Your Profile',
          style: TextStyle(color: black),
        ),
        backgroundColor: homeBackground,
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Welcome to Doggy Date, where our goal is to find your furry friend a mate!",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "But first, let's get you setup by creating your profile. Fill out the information below so we can get to know you and your furry friend!",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  // OWNER INFORMATION ----------------------------------------
                  const Text(
                    "The following information pertains to you, the owner.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // OWNER FIRST NAME
                  ValueListenableBuilder(
                    valueListenable: _ownerFirstNameController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerFirstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Your first name",
                          errorText: _submitted
                              ? _errorText(_ownerFirstNameController)
                              : null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // OWNER LAST NAME
                  ValueListenableBuilder(
                    valueListenable: _ownerLastNameController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerLastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Your last name",
                          errorText: _submitted
                              ? _errorText(_ownerLastNameController)
                              : null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // OWNER DOB
                  ValueListenableBuilder(
                    valueListenable: _ownerDOBController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerDOBController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: "Your date of birth",
                          errorText: _submitted
                              ? _errorText(_ownerDOBController)
                              : null,
                          prefixIcon: Icon(
                            Icons.cake,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // OWNER PHONE NUMBER
                  ValueListenableBuilder(
                    valueListenable: _ownerPhoneNumberController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerPhoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          errorText: _submitted
                              ? _errorText(_ownerPhoneNumberController)
                              : null,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // OWNER ADDRESS
                  ValueListenableBuilder(
                    valueListenable: _ownerAddressController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerAddressController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: "Street Address",
                          errorText: _submitted
                              ? _errorText(_ownerAddressController)
                              : null,
                          prefixIcon: Icon(
                            Icons.house,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // OWNER ZIPCODE
                  ValueListenableBuilder(
                    valueListenable: _ownerZipcodeController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _ownerZipcodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Zipcode",
                          prefixIcon: Icon(
                            Icons.house,
                            color: iconDarkGray,
                          ),
                          errorText: _submitted
                              ? _errorText(_ownerZipcodeController)
                              : null,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() => _submitted = true);
                        if (_ownerFirstNameController.value.text.isNotEmpty &&
                            _ownerLastNameController.value.text.isNotEmpty &&
                            _ownerDOBController.value.text.isNotEmpty &&
                            _ownerPhoneNumberController.value.text.isNotEmpty &&
                            _ownerAddressController.value.text.isNotEmpty &&
                            _ownerZipcodeController.value.text.isNotEmpty) {
                          setState(() => _isProcessing = true);
                          final newUser = {
                            "firstName": _ownerFirstNameController.value.text,
                            "lastName": _ownerLastNameController.value.text,
                            "dob": _ownerDOBController.value.text,
                            "phoneNumber":
                                _ownerPhoneNumberController.value.text,
                            "address": _ownerAddressController.value.text,
                            "zipcode": _ownerZipcodeController.value.text,
                          };

                          // update the user's display name to be the owner's first name
                          user.updateDisplayName(
                              _ownerFirstNameController.value.text);
                          print(user.displayName);
                          // add the newly created user to the users db in Firestore
                          try {
                            db.collection("users").doc(user.email).set(newUser);
                            setState(() => _isProcessing = false);
                            showSuccessAlert(
                              context,
                              'Your profile has been created successfully! Time to create your dog\'s profile.',
                            );
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateDogProfileScreen()));
                            print("success");
                          } on FirebaseException catch (e) {
                            print(e);
                            await showErrorAlert(context, defaultErrorMsg);
                          } catch (e) {
                            await showErrorAlert(context, defaultErrorMsg);
                            print(e);
                          }
                        }
                      },
                      child: const Text(
                        'Submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              heightFactor: 20,
              child: _isProcessing ? const CircularProgressIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }
}
