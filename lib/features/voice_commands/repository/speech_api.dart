import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/Notifications/screen/notifications_screen.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:enabled_try_1/utils/snackbar_&_fp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
        _speech.stop();
        _speech.cancel();
        return true;
      }

      final isAvailable = await _speech.initialize(
        onStatus: (status) => onListening(_speech.isListening),
        onError: (e) {
          _tts.speak("No dictionary words detected");
        },
      );

      if (isAvailable) {
        await _speech.listen(
            partialResults: false,
            onResult: (value) {
              if (ref.read(userProvider) != null) {
                executeCommand(value.recognizedWords, ref.read(userProvider)!,
                    context, screen);
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

  static void executeCommand(
      String res, UserModel user, BuildContext context, String screen) {
    final result = res.toLowerCase().trim();
    if (result.contains("home")) {
      switch (screen) {
        case "home":
          {
            _tts.speak("Already on home screen");
          }
          break;
        default:
          {
            Routemaster.of(context).push('/');
            _tts.speak("Navigated to home screen");
          }
      }
    } else if (result.contains("notifications") ||
        result.contains("notification")) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Notifications(user: user)));
      _tts.speak("Navigated to notifications");
    } else if (result.contains("profile")) {
      switch (screen) {
        case "profile":
          {
            _tts.speak("Already on profile screen");
          }
          break;
        default:
          {
            Routemaster.of(context).push('/profile/${user.uid}');
            _tts.speak("Navigated to profile");
          }
      }
    } else if (result.contains("post") &&
        (result.contains("image") || result.contains("images"))) {
      Routemaster.of(context).push("/add_image_screen");
      _tts.speak("Navigated to post image screen");
    } else if (result.contains("feed")) {
      switch (screen) {
        case "feed":
          {
            _tts.speak("Already on feed screen");
          }
          break;
        default:
          {
            Routemaster.of(context).push('/feed_page/${user.uid}');
            _tts.speak("Navigated to feed screen");
          }
      }
    } else if (result.contains("back")) {
      Routemaster.of(context).pop();
      _tts.speak("Navigated back");
    } else if (result.contains("post") &&
        (result.contains("edit") || result.contains("profile"))) {
      Routemaster.of(context).push("/edit_profile_screen");
      _tts.speak("Navigated to edit profile screen");
    } else {
      _tts.speak("Invalid command");
    }
  }
}
