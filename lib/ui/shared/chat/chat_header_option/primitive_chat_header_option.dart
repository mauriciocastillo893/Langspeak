import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class PrimitiveChatHeaderOption extends StatelessWidget {
  const PrimitiveChatHeaderOption({
    super.key,
    required this.iconDefault,
    required this.iconDefaultSelected,
    required this.text,
    required this.onPressed,
    this.margin = const EdgeInsets.only(),
    this.isSelected = false,
  });

  final IconData iconDefault;
  final IconData iconDefaultSelected;
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final EdgeInsets margin;
  final Color _colorOptionSelected = const Color.fromRGBO(12, 78, 107, 1);
  final Color _colorOptionNoSelected = const Color.fromRGBO(21, 106, 142, 1);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: isSelected ? _colorOptionSelected : _colorOptionNoSelected,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? iconDefaultSelected : iconDefault,
                  color: Colors.white,
                  size: 17,
                ),
                const SizedBox(
                  width: 5,
                ),
                NormalText(
                  text: text,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
