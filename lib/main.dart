// This is a Dart code for a Flutter mobile application that is used to register a user to the Junebank2u application. Below are comments on each section of the code:

// This section of the code imports all the necessary libraries to be used in the application.
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/apptextfield.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// The main() method initializes the Firebase app and runs the MyApp() widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// MyApp() is the root widget of the Flutter application. It defines the title of the application, the theme of the application, and sets the home widget to be RegistrationForm().
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Junebank2u App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const RegistrationForm(),
    );
  }
}

// RegistrationForm() is a StatefulWidget that has a mutable state. It calls _RegistrationFormState() to create a new state object.
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

// Gender is an enumeration that contains three values: Male, Female, and Nonbinary. state is a list of all the states in Malaysia.
enum Gender { Male, Female, Nonbinary }

const List<String> state = <String>[
  'Johor',
  'Kedah',
  'Kelantan',
  'Kuala Lumpur',
  'Labuan',
  'Melaka',
  'Negeri Sembilan',
  'Pahang',
  'Penang',
  'Perak',
  'Perlis',
  'Putrajaya',
  'Sabah',
  'Sarawak',
  'Selangor',
  'Terengganu'
];

// _RegistrationFormState is the mutable state of the RegistrationForm widget. It defines all the necessary text editing controllers for the different text fields in the form, as well as the current gender of the user, the current state selected in the dropdown menu, and the form key to validate the form.
class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardnumberController = TextEditingController();
  TextEditingController pinNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Gender _gender = Gender.Male;
  TextEditingController icController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String dropdownvalue = state.first;

// This method disposes of all the text editing controllers when the widget is removed from the tree.
  @override
  void dispose() {
    super.dispose();
    cardnumberController.dispose();
    pinNumberController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    icController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Register Junebank2u',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Welcome!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Please fill in this form.'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppTextField(
                      controller: cardnumberController,
                      keyboardType: TextInputType.number,
                      labelText: 'Card Number',
                      maxNum: 16,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextField(
                      controller: pinNumberController,
                      keyboardType: TextInputType.number,
                      labelText: 'PIN Number',
                      maxNum: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      obscureText: true,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.characters,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      labelText: 'Password',
                      obscureText: true,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordController.text = value;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordController.text = value;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      textInputAction: TextInputAction.next,
                    ),
                    AppTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email',
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio<Gender>(
                            value: Gender.Male,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          const Text('Male'),
                          Radio<Gender>(
                            value: Gender.Female,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          const Text('Female'),
                          Radio<Gender>(
                            value: Gender.Nonbinary,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          const Text('Non-binary'),
                        ],
                      ),
                    ),
                    AppTextField(
                      controller: icController,
                      keyboardType: TextInputType.number,
                      labelText: 'IC Number ',
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      maxNum: 12,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField<String>(
                        value: dropdownvalue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 5,
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                          });
                        },
                        items:
                            state.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        const snackBar =
                            SnackBar(content: Text('Passwords do not match.'));
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          addUserDetails(
                              cardnumberController.text,
                              pinNumberController.text,
                              nameController.text,
                              emailController.text,
                              _gender.name,
                              icController.text,
                              addressController.text,
                              dropdownvalue.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black),
                      child: const Text('REGISTER'),
                    ),
                  )),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  void addUserDetails(String cardNumber, String pinNumber, String name,
      String email, String gender, String ic, String address, String state) {
    try {
      if (_formKey.currentState!.validate()) {
        FirebaseFirestore.instance.collection('user').add({
          'cardNumber': cardNumber,
          'pinNumber': pinNumber,
          'name': name,
          'email': email,
          'gender': gender,
          'ic': ic,
          'address': address,
          'state': state,
        }).then((value) {
          return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Center(
                        child: Text('User successfully added.'),
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'))
                      ],
                    );
                  })
              .catchError((onError) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(onError.toString()))));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

// Explanation:

// 1. The code defines a RegistrationForm widget that returns a Scaffold with an AppBar and a body.
// 2. The body contains a SingleChildScrollView widget that contains a Padding widget that contains a Form widget. The Form widget contains a Column widget that contains several AppTextField and ListTile widgets.
// 3. The AppTextField widgets are custom widgets that extend the TextFormField widget and include additional features like input formatters and validators.
// 4. The ListTile widgets are used to display radio buttons for the user to select their gender.
// 5. The Submit button is an ElevatedButton widget that validates the form data and shows a SnackBar if the data is valid.
// 6. The form data is saved using the save method of the FormState object, which is obtained using the currentState property of the Form widget.
