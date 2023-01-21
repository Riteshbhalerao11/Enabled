import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  void loginUser(
      String email, String password, BuildContext ctx, bool isLoading) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential authres = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(() {
        isLoading = true;
      });
    } on FirebaseAuthException catch (err) {
      var message = "Something went wrong please try again";
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.red,
        padding: const EdgeInsetsDirectional.all(24),
      ));
      setState(() {
        isLoading = true;
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
                  LoginForm(loginUser),
                ],
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("forgot password ?",
                            style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
