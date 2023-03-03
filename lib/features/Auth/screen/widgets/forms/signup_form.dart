import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm(this.submitData, {super.key});
  final void Function(String username, String email, String password,
      String firstname, String bio) submitData;
  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  String _userBio = '';
  String _userName = '';
  String _firstName = '';
  bool _isMailValid = true;
  bool _isPassValid = true;
  bool _isNameValid = true;
  bool _isUNameValid = true;
  bool _isBioValid = true;

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
            _userPassword.trim(), _firstName.trim(), _userBio.trim());
      } else {
        showSnackBar(context, "Invalid field values", true);
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
                hint: _isMailValid ? null : "Invalid email address",
                child: TextFormField(
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      _isMailValid = false;
                      return "Invalid Email address";
                    }
                    _isMailValid = true;
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
                label: "User name input box. Double tap to activate",
                hint: _isUNameValid ? null : "Invalid user name",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      _isUNameValid = false;
                      return "Please enter username";
                    } else if (value.trim() != value.trim().toLowerCase() ||
                        value.trim().contains(" ")) {
                      _isUNameValid = false;
                      return "Enter valid username";
                    }
                    _isUNameValid = true;
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
                label: "Password input box. Double tap to activate",
                hint: _isPassValid ? null : "Invalid password",
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      _isPassValid = false;
                      return "Invalid Password";
                    }
                    _isPassValid = true;
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
                label: "First name input box. Double tap to activate",
                hint: _isNameValid ? null : "First name can't be null",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      _isNameValid = false;
                      return "Please enter username";
                    }
                    _isNameValid = true;
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                    hintText: "First name",
                    counterStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: defaultBorder,
                    errorStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onSaved: (newValue) {
                    _firstName = newValue!;
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
                hint: _isBioValid ? null : "Invalid bio",
                child: TextFormField(
                  validator: (value) {
                    if (value!.trim() == '') {
                      _isBioValid = false;
                      return "Please enter bio";
                    }
                    _isBioValid = true;
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
                semanticsLabel: "Loading",
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
