import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/ai_array.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:intl/intl.dart';

class PrimitiveBubleChat extends StatefulWidget {
  final int index;
  final int lengthArray;
  final String textToDisplay;
  final DateTime date;
  final WhoSend whoSend;

  const PrimitiveBubleChat({
    super.key,
    required this.index,
    required this.lengthArray,
    required this.textToDisplay,
    required this.date,
    required this.whoSend,
  });

  @override
  State<PrimitiveBubleChat> createState() => _PrimitiveBubleChatState();
}

class _PrimitiveBubleChatState extends State<PrimitiveBubleChat> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(widget.date);

    return Container(
        margin: EdgeInsets.only(
            right: widget.whoSend == WhoSend.ai ? 50 : 5,
            top: 5,
            bottom: widget.lengthArray == widget.index ? 20 : 5,
            left: widget.whoSend == WhoSend.me ? 50 : 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.whoSend == WhoSend.me
              ? const Color.fromRGBO(105, 201, 242, 1)
              : const Color.fromRGBO(123, 198, 153, 1),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
            bottomLeft: widget.whoSend == WhoSend.me
                ? const Radius.circular(10)
                : const Radius.circular(0),
            bottomRight: widget.whoSend == WhoSend.ai
                ? const Radius.circular(10)
                : const Radius.circular(0),
          ),
        ),
        child: SizedBox(
          child: Column(
            children: [
              NormalText(
                text: widget.textToDisplay,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.15,
                ),
                textAlign: TextAlign.justify,
                alignment: widget.whoSend == WhoSend.me
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                maxLinesUnlimited: true,
              ),
              NormalText(
                padding: const EdgeInsets.only(top: 2.5),
                text: formattedDate,
                textStyle: const TextStyle(
                    color: Colors.white, fontSize: 10, height: 1.15),
                alignment: widget.whoSend == WhoSend.me
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
              ),
            ],
          ),
        ));
  }
}
