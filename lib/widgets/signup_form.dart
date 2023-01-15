import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  String? _userEmail = '';
  String? _userPassword = '';
  String? _bio = '';

  final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white));

  void _trySubmit() {
    final isValid = _formkey.currentState?.validate();
    // FocusScope.of(context).unfocus();
    if (isValid != null) {
      if (isValid) {
        _formkey.currentState?.save();
        print(_userEmail);
        print(_userPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.length < 7) {
                    return "Invalid Password";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    fontFamily: 'Lora', fontSize: 16, color: Color(0xFF454545)),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email address",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder),
                onSaved: (newValue) {
                  _userPassword = newValue;
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "User name",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder),
                onSaved: (newValue) {
                  _userEmail = newValue;
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
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder),
                onSaved: (newValue) {
                  _userPassword = newValue;
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                maxLines: 3,
                style: const TextStyle(
                    fontFamily: 'Lora', fontSize: 16, color: Color(0xFF454545)),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your Bio",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder,
                    errorBorder: defaultBorder),
                onSaved: (newValue) {
                  _userEmail = newValue;
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: _trySubmit,
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(396, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  child: const Text("Signup",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2))),
            ),
          ],
        ));
  }
}
