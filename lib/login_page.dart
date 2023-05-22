import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/homepage.dart';
import 'apptextfield.dart';
import 'register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text('Login to Junebank2u',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 5,
        ),
        backgroundColor: Colors.amber[200],
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Welcome to Junebank2u',
                          style: TextStyle(fontSize: 28)),
                      const SizedBox(height: 5),
                      const Text('Please login.',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 5),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
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
                              textInputAction: TextInputAction.done,
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
                                if (prefs != null) {
                                  userLogin(emailController.text,
                                      passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.black),
                              child: const Text('LOGIN'),
                            ),
                          )),
                      const SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
                          child: TextButton(
                            child: const Text('Sign Up'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationForm()));
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                          child: TextButton(
                            child: const Text('Forgot Password?'),
                            onPressed: () {},
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> userLogin(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
            prefs?.setString('email', email);
            prefs?.setString('password', password);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(email)));
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Center(
                    child: Text(
                        'Please verify your e-mail. If you don\'t found, please check \'Spam\' folder.'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
