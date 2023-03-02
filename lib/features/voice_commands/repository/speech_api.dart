import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';

final voiceStateProvider = StateProvider<bool>((ref) => false);

class SpeechApi {
  static final FlutterTts _tts = FlutterTts();
  static final _speech = SpeechToText();
  static bool result = false;
  static List<String> res = [];
  static Future<bool> toggleRecording(
      {required String screen,
      required WidgetRef ref,
      required BuildContext context,
      required ValueChanged<bool> onListening,
      required Function(String err) onError}) async {
    try {
      if (_speech.isListening) {
        onListening(false);
        _speech.stop();
        _speech.cancel();
        return true;
      }

      final isAvailable = await _speech.initialize(
        onError: (e) {
          onListening(false);
          _tts.speak("No dictionary words detected");
        },
      );

      if (isAvailable) {
        onListening(_speech.isAvailable);
        await _speech.listen(
            partialResults: false,
            onResult: (value) {
              onListening(false);
              if (ref.read(userProvider) != null) {
                if (screen == 'home') {
                  executeHomeCommand(value.recognizedWords,
                      ref.read(userProvider)!, context, onListening);
                } else if (screen == "profile") {
                  executeProfileCommand(value.recognizedWords,
                      ref.read(userProvider)!, context, onListening);
                } else if (screen == "feed") {
                  executeFeedCommand(value.recognizedWords,
                      ref.read(userProvider)!, context, onListening);
                } else if (screen == "notifications") {
                  executeNotificationsCommand(value.recognizedWords,
                      ref.read(userProvider)!, context, onListening);
                }
              } else {
                showSnackBar(
                    context, "Something went wrong. Restart the app", true);
              }
            });
      } else {
        onError("Voice commands not avaialable on this device");
      }

      return isAvailable;
    } on Exception catch (e) {
      onError("An error occured : ${e.toString()}");
      return false;
    }
  }

  static void executeHomeCommand(String res, UserModel user,
      BuildContext context, Function onListen) async {
    onListen(false);
    final result = res.toLowerCase().trim();
    if (result.contains("home")) {
      _tts.speak("Already on home screen");
    } else if (result.contains("notifications") ||
        result.contains("notification")) {
      Routemaster.of(context).push("/notifications/${user.uid}");
      _tts.speak("Navigated to notifications");
    } else if (result.contains("post") &&
        (result.contains("image") || result.contains("images"))) {
      Routemaster.of(context).push("/add_image_screen");
      _tts.speak("Navigated to post image screen");
    } else if ((result.contains("edit") && result.contains("profile"))) {
      Routemaster.of(context).push("/edit_profile_screen");
      _tts.speak("Navigated to edit profile screen");
    } else if (result.contains("profile")) {
      Routemaster.of(context).push('/profile/${user.uid}');
    } else if (result.contains("feed")) {
      Routemaster.of(context).push('/feed_page/${user.uid}');
      _tts.speak("Navigated to feed screen");
    } else if (result.contains("back")) {
      Routemaster.of(context).pop();
      _tts.speak("Navigated back");
    } else if (result.contains("my story")) {
      Routemaster.of(context).push("/my_story/${user.uid}");
    } else {
      _tts.speak("Invalid command");
    }
  }

  static void executeProfileCommand(String res, UserModel user,
      BuildContext context, Function onListen) async {
    onListen(false);
    final result = res.toLowerCase().trim();
    if (result.contains("home")) {
      Routemaster.of(context).push('/');
      _tts.speak("Navigated to home screen");
    } else if (result.contains("notifications") ||
        result.contains("notification")) {
      Routemaster.of(context).push("/profile/${user.uid}/notifications");
      _tts.speak("Navigated to notifications");
    } else if (result.contains("post") &&
        (result.contains("image") || result.contains("images"))) {
      Routemaster.of(context).push('/profile/${user.uid}/add_posts_screen');
      _tts.speak("Navigated to post image screen");
    } else if ((result.contains("edit") && result.contains("profile"))) {
      Routemaster.of(context).push("/profile/${user.uid}/edit_profile_screen");
      _tts.speak("Navigated to edit profile screen");
    } else if (result.contains("profile")) {
      _tts.speak("Already on profile page");
    } else if (result.contains("feed")) {
      Routemaster.of(context).push('/profile/${user.uid}/feed_screen');
      _tts.speak("Navigated to feed screen");
    } else if (result.contains("my story")) {
      Routemaster.of(context).push('/profile/${user.uid}/my_story');
      _tts.speak("Navigated to my story screen");
    } else if (result.contains("back")) {
      Routemaster.of(context).pop();
      _tts.speak("Navigated back");
    } else {
      _tts.speak("Invalid command");
    }
  }

  static void executeFeedCommand(String res, UserModel user,
      BuildContext context, Function onListen) async {
    onListen(false);
    final result = res.toLowerCase().trim();
    if (result.contains("home")) {
      Routemaster.of(context).push('/');
      _tts.speak("Navigated to home screen");
    } else if (result.contains("notifications") ||
        result.contains("notification")) {
      Routemaster.of(context).push("/feed_page/${user.uid}/notifications");
      _tts.speak("Navigated to notifications");
    } else if (result.contains("post") &&
        (result.contains("image") || result.contains("images"))) {
      Routemaster.of(context).push('/feed_page/${user.uid}/add_posts_screen');
      _tts.speak("Navigated to post image screen");
    } else if ((result.contains("edit") && result.contains("profile"))) {
      Routemaster.of(context)
          .push("/feed_page/${user.uid}/edit_profile_screen");
      _tts.speak("Navigated to edit profile screen");
    } else if (result.contains("profile")) {
      Routemaster.of(context).push("/feed_page/${user.uid}/profile");
      _tts.speak("Navigated to profile page");
    } else if (result.contains("feed")) {
      _tts.speak("Already on feed screen");
    } else if (result.contains("my story")) {
      Routemaster.of(context).push('/feed_page/${user.uid}/my_story');
      _tts.speak("Navigated to my story screen");
    } else if (result.contains("back")) {
      Routemaster.of(context).pop();
      _tts.speak("Navigated back");
    } else {
      _tts.speak("Invalid command");
    }
  }

  static void executeNotificationsCommand(String res, UserModel user,
      BuildContext context, Function onListen) async {
    onListen(false);
    final result = res.toLowerCase().trim();
    if (result.contains("home")) {
      Routemaster.of(context).push('/');
      _tts.speak("Navigated to home screen");
    } else if (result.contains("notifications") ||
        result.contains("notification")) {
      _tts.speak("Already on notifications");
    } else if (result.contains("post") &&
        (result.contains("image") || result.contains("images"))) {
      Routemaster.of(context)
          .push('/notifications/${user.uid}/add_posts_screen/add_image_screen');
      _tts.speak("Navigated to post image screen");
    } else if ((result.contains("edit") && result.contains("profile"))) {
      Routemaster.of(context)
          .push("/notifications/${user.uid}/edit_profile_screen");
      _tts.speak("Navigated to edit profile screen");
    } else if (result.contains("profile")) {
      Routemaster.of(context).push("/notifications/${user.uid}/profile");
    } else if (result.contains("feed")) {
      Routemaster.of(context).push('/profile/${user.uid}/feed_screen');
      _tts.speak("Navigated to feed screen");
    } else if (result.contains("my story")) {
      Routemaster.of(context).push('/navigations/${user.uid}/my_story');
      _tts.speak("Navigated to my story screen");
    } else if (result.contains("back")) {
      Routemaster.of(context).pop();
      _tts.speak("Navigated back");
    } else {
      _tts.speak("Invalid command");
    }
  }
}
