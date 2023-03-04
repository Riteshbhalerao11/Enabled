import 'dart:convert';
import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/features/My_story/repository/my_story_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyStory extends ConsumerStatefulWidget {
  const MyStory({super.key, required this.uid});
  final String? uid;

  @override
  ConsumerState<MyStory> createState() => _MyStoryState();
}

class _MyStoryState extends ConsumerState<MyStory> {
  quill.QuillController _controller = quill.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(myStoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Story"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 10),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.black,
              )
            : FloatingActionButton(
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                onPressed: () {
                  var json =
                      jsonEncode(_controller.document.toDelta().toJson());
                  ref.read(myStoryProvider.notifier).storeData(
                      ctx: context, uid: widget.uid!, jsonData: json);
                  ref.refresh(myStoryProvider);
                },
                child: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                    top: BorderSide(color: Colors.grey.shade300)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ]),
            width: double.infinity,
            child: quill.QuillToolbar.basic(
              // iconTheme: ,
              dialogTheme: quill.QuillDialogTheme(
                  dialogBackgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer),
              controller: _controller,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: ref.watch(futureGetStoryData(widget.uid!)).when(
                        data: (data) {
                          if (data == "") {
                            _controller.moveCursorToEnd();
                            return quill.QuillEditor.basic(
                                controller: _controller, readOnly: false);
                          } else {
                            final jdata = jsonDecode(data);
                            _controller.document =
                                quill.Document.fromJson(jdata);
                            _controller.moveCursorToEnd();
                            return quill.QuillEditor.basic(
                                controller: _controller, readOnly: false);
                          }
                        },
                        error: (error, st) =>
                            ErrorText(error: error.toString()),
                        loading: () => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
