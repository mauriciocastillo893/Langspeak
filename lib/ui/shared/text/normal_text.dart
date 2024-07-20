import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Alignment alignment;
  final TextOverflow overflow;
  final EdgeInsets padding;
  final int maxLines;

  const NormalText({
    super.key,
    this.text = "Text not defined",
    this.padding = const EdgeInsets.all(0),
    this.textStyle =
        const TextStyle(color: Colors.white, height: 1.15, fontSize: 14),
    this.textAlign = TextAlign.left,
    this.alignment = Alignment.center,
    this.overflow = TextOverflow.clip,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: textStyle,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
