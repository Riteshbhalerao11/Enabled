import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var isLoading = false;

  void submitData(
    String username,
    String email,
    String password,
    String bio,
    BuildContext ctx,
  ) async {
    UserCredential authres;
    try {
      setState(() {
        isLoading = true;
      });
      authres = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection('users').doc(authres.user!.uid).set({
        'username': username,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': [],
        'following': [],
      });
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (err) {
      var message = "Something went wrong , Please try again !";
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.red,
          padding: const EdgeInsetsDirectional.all(24),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).viewPadding.top;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight - statusBar,
          child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enabled",
                    style: TextStyle(
                        height: 0.5,
                        fontSize: 72,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        shadows: [
                          Shadow(
                              offset: Offset(1, 5),
                              blurRadius: 4.0,
                              color: Colors.black26)
                        ]),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Share your story",
                    style: TextStyle(
                        height: 0.5,
                        fontFamily: 'Merriweather',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 32),
                  SignupForm(submitData, isLoading),
                ],
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Back to login",
                          style: TextStyle(
                              fontFamily: 'Lora',
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
