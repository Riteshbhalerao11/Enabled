import 'package:flutter/material.dart';

class BioBox extends StatelessWidget {
  const BioBox({super.key, required this.bio});
  final String bio;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(
                bio,
                style: const TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: "PTSans"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
