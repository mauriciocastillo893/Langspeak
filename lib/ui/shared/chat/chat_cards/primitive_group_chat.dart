import 'package:flutter/material.dart';
import 'package:langspeak/domain/models/message_model/message_model.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class PrimitiveGroupChat extends StatefulWidget {
  final List<MessageModel> arrayToDisplay;

  const PrimitiveGroupChat({super.key, required this.arrayToDisplay});

  @override
  State<PrimitiveGroupChat> createState() => _PrimitiveGroupChatState();
}

class _PrimitiveGroupChatState extends State<PrimitiveGroupChat> {
  @override
  Widget build(BuildContext context) {
    if (widget.arrayToDisplay.isEmpty) {
      return const SizedBox(
        child: NormalText(
          text: "Groups is not available right now",
          // text: "Join or create a new group chat",
        ),
      );
    }
    return ListView.builder(
        itemCount: widget.arrayToDisplay.length,
        itemBuilder: (context, index) {
          final message = widget.arrayToDisplay[index];
          return Container(
              margin: EdgeInsets.only(top: index == 0 ? 0 : 2.5),
              height: MediaQuery.of(context).size.width * 0.14,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(20, 121, 164, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 10 : 0),
                    topRight: Radius.circular(index == 0 ? 10 : 0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      // color: Colors.red,
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child:
                                Image.asset('assets/images/langspeak_2.webp')),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: message.whoSendName.toString(),
                            alignment: Alignment.centerLeft,
                          ),
                          NormalText(
                              text:
                                  "Last message: ${message.audio != null ? 'Audio' : message.text}",
                              alignment: Alignment.centerLeft,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.025)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      // color: Colors.green,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalText(
                              text:
                                  "${message.date.day}/${message.date.month}/${message.date.year}",
                              padding: const EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.025),
                            ),
                            NormalText(
                                text:
                                    "${message.date.hour}:${message.date.minute}",
                                padding: const EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.025)),
                          ]),
                    ),
                  )
                ],
              ));
        });
  }
}
