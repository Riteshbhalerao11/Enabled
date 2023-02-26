import 'dart:io';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70,
      ),
      height: 300,
      width: double.infinity,
    );
  }
}

class FilledPictureUrl extends StatelessWidget {
  const FilledPictureUrl({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        height: 300,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InteractiveViewer(
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}

class FilledPicture extends StatelessWidget {
  const FilledPicture({super.key, required this.img});
  final File img;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        height: 300,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InteractiveViewer(child: Image.file(img, fit: BoxFit.contain)),
        ));
  }
}

class NetworkPicture extends StatelessWidget {
  const NetworkPicture({super.key, required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        height: 300,
        width: double.infinity,
        child: ClipRRect(
          child:
              InteractiveViewer(child: Image.network(img, fit: BoxFit.contain)),
        ));
  }
}
