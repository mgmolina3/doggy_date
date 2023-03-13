import 'package:doggy_date/users/dog.dart';
import 'package:doggy_date/utils/alerts.dart';
import 'package:doggy_date/utils/custom_colors.dart';
import 'package:doggy_date/utils/custome_widgets.dart';
import 'package:doggy_date/utils/errors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/custom_icons.dart';

class CreateDogProfileScreen extends StatefulWidget {
  const CreateDogProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateDogProfileScreen> createState() => _CreateDogProfileScreenState();
}

class _CreateDogProfileScreenState extends State<CreateDogProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  // DOG INFORMATION
  final TextEditingController _dogNameController = TextEditingController();
  final TextEditingController _dogDOBController = TextEditingController();
  final TextEditingController _dogWeightController = TextEditingController();
  String dogSexValue = 'Male';
  String dogBreedValue = 'Chihuahua';
  String dogPurebredValue = 'No';
  String dogRabiesValue = 'No';
  String dogDHPPValue = 'No';
  String dogDistemperValue = 'No';
  String dogParvovirusValue = 'No';

  bool _submitted = false;
  bool _isProcessing = true;

  List<String> yesNoDropdown = ['No', 'Yes'];
  List<String> sexDropDown = ['Male', 'Female'];

  String? _errorText(TextEditingController controller) {
    final text = controller.value.text;

    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  // set state for dox sex and dog breed
  void onChangedActionDogSex(newValue) {
    setState(() {
      dogSexValue = newValue!;
    });
  }

  void onChangedActionDogBreed(newValue) {
    setState(() {
      dogBreedValue = newValue!;
    });
  }

  @override
  void dispose() {
    _dogNameController.dispose();
    _dogDOBController.dispose();
    _dogWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //     Duration.zero,
    //     () => showSuccessAlert(context,
    //         'Your profile has been created successfully! Time to create your dog\'s profile.'));

    User? user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference dogBreeds =
        FirebaseFirestore.instance.collection('dog_breeds');

    // TODO: Weight and Color
    //String dogColorValue = 'White';

    List<DropdownMenuItem<Object>> getDogBreedsItems(
        AsyncSnapshot<QuerySnapshot> snapshot) {
      return snapshot.data!.docs
          .map((doc) => DropdownMenuItem(value: doc.id, child: Text(doc.id)))
          .toList();
    }

    Future<QuerySnapshot> getDogBreedsFromDB() {
      return db.collection("dog_breeds").get();
    }

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
                  const SizedBox(height: 15),
                  // DOG INFORMATION ----------------------------------------
                  const Text(
                    "Please fill out the following information which pertains to your dog.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // DOG NAME
                  ValueListenableBuilder(
                    valueListenable: _dogNameController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _dogNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Name of Your Dog",
                          errorText: _submitted
                              ? _errorText(_dogNameController)
                              : null,
                          prefixIcon: Icon(
                            CustomIcons.dog,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),
                  // DOG DOB
                  ValueListenableBuilder(
                    valueListenable: _dogDOBController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _dogDOBController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: "Dog's date of birth",
                          errorText:
                              _submitted ? _errorText(_dogDOBController) : null,
                          prefixIcon: Icon(
                            Icons.cake,
                            color: iconDarkGray,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),
                  // DOG WEIGHT
                  ValueListenableBuilder(
                    valueListenable: _dogWeightController,
                    builder: (context, TextEditingValue value, __) {
                      return TextField(
                        controller: _dogWeightController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Dog's weight",
                          errorText: _submitted
                              ? _errorText(_dogWeightController)
                              : null,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),
                  // DOG'S SEX
                  textDropdownButton('Sex of your dog: ', dogSexValue,
                      sexDropDown, onChangedActionDogSex),
                  const SizedBox(height: 15),
                  // DOG'S BREED
                  FutureBuilder(
                    future: getDogBreedsFromDB(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      print("SNAPSHOT: $snapshot");
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: [
                            const Text('Dog breed: '),
                            DropdownButton(
                              value: dogBreedValue,
                              items: getDogBreedsItems(snapshot),
                              onChanged: onChangedActionDogBreed,
                              hint: const Text('dog breed'),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() => _submitted = true);
                        if (_dogNameController.value.text.isNotEmpty &&
                            _dogDOBController.value.text.isNotEmpty &&
                            _dogWeightController.value.text.isNotEmpty) {
                          setState(() => _isProcessing = true);
                          final newdog = {
                            "dogName": _dogNameController.value.text,
                            "dogWeight": _dogWeightController.value.text,
                            "dogDob": _dogDOBController.value.text,
                            "dogSex": dogSexValue,
                            "dogBreed": dogBreedValue,
                          };
                          print(user.displayName);
                          // add the newly created dog to the corresponding owner in the users db in Firestore
                          try {
                            db
                                .collection("users")
                                .doc(user.email)
                                .set(newdog, SetOptions(merge: true));
                            setState(() => _isProcessing = false);
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CreateDogProfileScreen()));
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
          ],
        ),
      ),
    );
  }
}
