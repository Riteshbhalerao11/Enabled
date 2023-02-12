import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Auth/screen/widgets/title.dart';
import 'package:enabled_try_1/features/Auth/screen/widgets/forms/signup_form.dart';
import 'package:enabled_try_1/features/auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/auth/screen/widgets/subtitle.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  void submitData(
    String username,
    String email,
    String password,
    String bio,
  ) async {
    ref
        .read(authControllerProvider.notifier)
        .signupUser(username, email, password, bio, context);
  }

  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).viewPadding.top;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  const TitleWidg(),
                  const SizedBox(
                    height: 12,
                  ),
                  const Tagline(),
                  const SizedBox(height: 32),
                  SignupForm(submitData),
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
