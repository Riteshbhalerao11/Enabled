import 'dart:io';
import 'package:enabled_try_1/features/Add_post/controller/post_controller.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDescription extends ConsumerStatefulWidget {
  const AddDescription(
      {super.key, required this.profilepic, required this.user});
  final File? profilepic;
  final UserModel user;
  @override
  ConsumerState<AddDescription> createState() => _AddDescriptionState();
}

class _AddDescriptionState extends ConsumerState<AddDescription> {
  String _caption = '';
  String _altText = '';
  final _formkey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid != null) {
      if (isValid) {
        _formkey.currentState?.save();
        ref.read(postControllerProvider.notifier).shareImagePost(
            ctx: context,
            image: widget.profilepic!,
            caption: _caption,
            altText: _altText,
            user: widget.user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(postControllerProvider);
    var statusBar = MediaQuery.of(context).viewPadding.top;
    var deviceHeight = MediaQuery.of(context).size.height;
    var appBarHeight = AppBar().preferredSize.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Post image",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight - statusBar - appBarHeight,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 16, left: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: "Enter Caption"),
                          // controller: captionEditingController,
                          onSaved: (newValue) {
                            _caption = newValue!;
                          },
                          maxLines: 6,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter caption';
                            }
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "PTSans"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 12, right: 16, left: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            labelText: "Enter Alt text (Describe your post)",
                          ),
                          // controller: altTextEditingController,
                          onSaved: (value) {
                            _altText = value!;
                          },
                          maxLines: 6,
                          validator: (value) {
                            if (value == '') {
                              return 'Alternate text is mandatory';
                            }
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "PTSans"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  if (!isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        child: Text(
                          "Post",
                          style: TextStyle(
                              fontFamily: "Signika",
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontSize: 18,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  if (isLoading)
                    const CircularProgressIndicator(
                      color: Colors.white,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
