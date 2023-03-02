import 'dart:convert';

import 'package:enabled_try_1/core/Common/error_text.dart';
import 'package:enabled_try_1/features/My_story/repository/my_story_repository.dart';
import 'package:flutter/material.dart';
import "package:flutter_quill/flutter_quill.dart" as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadOnlyMyStory extends ConsumerWidget {
  ReadOnlyMyStory({super.key, required this.uid});
  final String uid;
  quill.QuillController _controller = quill.QuillController.basic();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Story"),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: ref.watch(futureGetStoryData(uid)).when(
                      data: (data) {
                        if (data == "") {
                          return const Center(
                            child: Text(
                              "No story written yet..",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Pacifico",
                                  letterSpacing: 1.2,
                                  fontSize: 24),
                            ),
                          );
                        } else {
                          final jdata = jsonDecode(data);
                          _controller.document = quill.Document.fromJson(jdata);
                          _controller.moveCursorToEnd();
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: quill.QuillEditor.basic(
                                controller: _controller, readOnly: true),
                          );
                        }
                      },
                      error: (error, st) => ErrorText(error: error.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
