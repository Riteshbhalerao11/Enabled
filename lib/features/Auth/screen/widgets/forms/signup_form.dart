import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm(this.submitData, {super.key});
  final void Function(
      String username, String email, String password, String bio, String name) submitData;
  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  String _userBio = '';
  String _userName = '';
  String _nameOfUser = '';

  final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white));

  void _trySubmit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid != null) {
      if (isValid) {
        _formkey.currentState?.save();
        widget.submitData(_userName.trim(), _userEmail.trim(),
            _userPassword.trim(), _userBio.trim(), _nameOfUser.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signupAuthControllerProvider);
    return Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                excludeSemantics: true,
                label: "Email address input box. Double tap to activate",
                child: TextFormField(
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return "Invalid Email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 16,
                      color: Color(0xFF454545)),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email address",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder,
                    errorStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (newValue) {
                    _userEmail = newValue!;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                excludeSemantics: true,
                label: "Username input box. Double tap to activate",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      return "Please enter username";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 16,
                      color: Color(0xFF454545)),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "User name",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder,
                    errorStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (newValue) {
                    _userName = newValue!;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                excludeSemantics: true,
                label: "Name input box. Double tap to activate",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      return "Please enter name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 16,
                      color: Color(0xFF454545)),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Name",
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder,
                    errorStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (newValue) {
                    _nameOfUser = newValue!;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                excludeSemantics: true,
                label: "Password input box. Double tap to activate",
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      return "Invalid Password";
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 16,
                      color: Color(0xFF454545)),
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
                  onSaved: (newValue) {
                    _userPassword = newValue!;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Semantics(
                excludeSemantics: true,
                label: "Bio input box. Double tap to activate",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      return "Please enter bio";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 3,
                  style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 16,
                      color: Color(0xFF454545)),
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
                      errorBorder: defaultBorder,
                      errorStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  onSaved: (newValue) {
                    _userBio = newValue!;
                  },
                ),
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
