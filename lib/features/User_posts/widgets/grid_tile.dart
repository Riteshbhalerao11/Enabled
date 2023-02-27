import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ))),
    );
  }
}
