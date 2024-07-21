import 'package:flutter/material.dart';

class FractionallySizedBoxButton extends StatelessWidget {
  final String buttonText;
  final double fontSizeText;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color colorBackgroundButton;
  final Color colorTextButton;
  final Color colorBorderButton;
  final Alignment alignment;
  final EdgeInsets padding;
  final double widthFactor;
  final double heightFactor;

  const FractionallySizedBoxButton({
    super.key,
    this.buttonText = 'Text',
    this.fontSizeText = 19,
    this.onPressed = _defaultOnPressed,
    this.borderRadius = 7.5,
    this.colorBackgroundButton = const Color.fromRGBO(123, 198, 153, 1),
    this.colorTextButton = Colors.white,
    this.colorBorderButton = const Color.fromRGBO(123, 198, 153, 1),
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.only(left: 30, right: 30),
    this.widthFactor = 1,
    this.heightFactor = 1,
  });

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorBackgroundButton,
                textStyle: TextStyle(
                  color: colorTextButton,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: colorBorderButton)),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: fontSizeText),
              )),
        ),
      ),
    );
  }
}
