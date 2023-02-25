import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class CaptionBox extends StatelessWidget {
  const CaptionBox({super.key, required this.caption});
  final String caption;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          child: ExpandableText(
            caption,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 16,
                fontFamily: "PTSans"),
            expandText: 'Show more',
            collapseText: "Show less",
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
