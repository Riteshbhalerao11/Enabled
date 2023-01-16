import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top,
          child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
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
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Share your story",
                    style: TextStyle(
                        height: 0.5,
                        fontFamily: 'Merriweather',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  SizedBox(height: 32),
                  LoginForm(),
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
