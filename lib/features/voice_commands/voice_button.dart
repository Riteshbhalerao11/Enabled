import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:enabled_try_1/features/voice_commands/repository/speech_api.dart';
import 'package:enabled_try_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceButton extends ConsumerStatefulWidget {
  const VoiceButton({super.key, required this.user, required this.screen});
  final String screen;
  final UserModel user;
  @override
  ConsumerState<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends ConsumerState<VoiceButton> {
  @override
  Widget build(BuildContext context) {
    final isListening = ref.watch(voiceStateProvider);

    return FloatingActionButton(
      heroTag: "voice",
      backgroundColor: isListening
          ? Theme.of(context).colorScheme.onSecondaryContainer
          : Theme.of(context).colorScheme.onPrimaryContainer,
      onPressed: toggleRecording,
      child: Icon(
        isListening ? Icons.mic : Icons.mic_none,
        size: 36,
        color: isListening
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }

  Future toggleRecording() {
    ref.read(userProvider.notifier).update((state) => widget.user);
    return SpeechApi.toggleRecording(
      screen: widget.screen,
      ref: ref,
      context: context,
      onError: (err) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err))),
      onListening: (isListening) {
        ref.read(voiceStateProvider.notifier).update((state) => isListening);
      },
    );
  }
}
