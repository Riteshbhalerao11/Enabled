import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Auth/screen/widgets/title.dart';
import 'package:enabled_try_1/features/Auth/screen/widgets/forms/login_form.dart';
import 'package:enabled_try_1/features/auth/screen/widgets/forgot_pass.dart';
import 'package:enabled_try_1/features/auth/screen/widgets/subtitle.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  loginUser(String email, String password, BuildContext ctx) async {
    ref
        .read(authControllerProvider.notifier)
        .loginUser(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).viewPadding.top;
    var deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                      MergeSemantics(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            TitleWidg(),
                            SizedBox(
                              height: 12,
                            ),
                            Tagline(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      LoginForm(loginUser)
                    ],
                  ),
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 48),
                      child: ForgotPass(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
