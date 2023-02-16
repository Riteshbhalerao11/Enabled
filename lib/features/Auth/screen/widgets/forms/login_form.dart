import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginForm extends ConsumerStatefulWidget {
  final void Function(String email, String password, BuildContext ctx)
      loginUser;
  const LoginForm(this.loginUser, {super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white));

  void _trySubmit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid != null) {
      if (isValid) {
        _formkey.currentState?.save();
        widget.loginUser(_userEmail, _userPassword, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    print(isLoading);
    return Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return "Please enter valid email address";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    fontFamily: 'Lora', fontSize: 16, color: Color(0xFF454545)),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "User name",
                  border: defaultBorder,
                  enabledBorder: defaultBorder,
                  focusedBorder: defaultBorder,
                  errorStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                ),
                onSaved: (newValue) {
                  _userEmail = newValue!;
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.length < 7) {
                    return "Invalid Password";
                  }
                  return null;
                },
                style: const TextStyle(
                    fontFamily: 'Lora', fontSize: 16, color: Color(0xFF454545)),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: defaultBorder,
                  enabledBorder: defaultBorder,
                  focusedBorder: defaultBorder,
                  errorStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                obscureText: true,
                onSaved: (newValue) {
                  _userPassword = newValue!;
                },
              ),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            if (!isLoading)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: _trySubmit,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(396, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 2))),
              ),
            Row(
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 16, right: 6),
                        child: const Divider(
                          color: Color(0xFFD9D9D9),
                          height: 72,
                          thickness: 1.5,
                        ))),
                const Text(
                  "New here ?",
                  style: TextStyle(
                      fontFamily: 'Lora', fontSize: 16, color: Colors.white),
                ),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 6, right: 16),
                        child: const Divider(
                          color: Color(0xFFD9D9D9),
                          height: 72,
                          thickness: 1.5,
                        ))),
              ],
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: TextButton(
                  onPressed: () {
                    Routemaster.of(context).push('/signup');
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 2),
                  ),
                ))
          ],
        ));
  }
}
