import 'package:flutter/material.dart';

class NormalTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final double? width;
  final double height;
  final double fontSize;
  final Color colorBorder;
  final Color colorBackground;
  final TextStyle textStyle;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets padding;
  final Alignment alignment;
  final Icon? suffixIcon;
  final VoidCallback? onIconPressed;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const NormalTextField({
    super.key,
    this.hintText = 'Text',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.width = double.infinity,
    this.height = 46,
    this.fontSize = 16,
    this.colorBorder = const Color.fromRGBO(123, 198, 153, 1),
    this.colorBackground = const Color.fromRGBO(51, 56, 78, 1),
    this.textStyle = const TextStyle(color: Colors.white),
    this.borderRadius = 7.5,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    this.padding = const EdgeInsets.only(left: 30, right: 30),
    this.alignment = Alignment.center,
    this.suffixIcon,
    this.onIconPressed,
    this.onChanged,
    this.nextFocusNode,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<NormalTextField> createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends State<NormalTextField> {
  late bool obscureTextLocal;

  @override
  void initState() {
    super.initState();
    // if (widget.obscureText) {
    //   obscureTextLocal = true;
    // } else {
    //   obscureTextLocal = !(widget.suffixIcon != null);
    // }
    obscureTextLocal = widget.obscureText;
  }

  void toggleObscureText() {
    setState(() {
      obscureTextLocal = !obscureTextLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            obscureText: obscureTextLocal,
            enabled: widget.enabled,
            style: widget.textStyle,
            onFieldSubmitted: (_) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }
            },
            onTapOutside: (event) => widget.focusNode.unfocus(),
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.textStyle.color,
                fontSize: widget.fontSize,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.colorBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius + 2.5),
                borderSide: BorderSide(
                  color: widget.colorBorder,
                ),
              ),
              filled: true,
              fillColor: widget.colorBackground,
              contentPadding: widget.contentPadding,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon!.icon,
                        color: widget.textStyle.color,
                      ),
                      onPressed: widget.onIconPressed ?? toggleObscureText,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
