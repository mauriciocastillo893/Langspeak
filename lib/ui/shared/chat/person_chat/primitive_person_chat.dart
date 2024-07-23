import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class PrimitivePersonChat extends StatefulWidget {
  const PrimitivePersonChat({super.key});

  @override
  State<PrimitivePersonChat> createState() => _PrimitivePersonChatState();
}

class _PrimitivePersonChatState extends State<PrimitivePersonChat> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
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
                          const NormalText(
                            text: "Mauricio Castillo",
                            alignment: Alignment.centerLeft,
                          ),
                          NormalText(
                              text: "Last message: Hi, how are you?",
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
                              text: "19/10/2024",
                              padding: const EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.025),
                            ),
                            NormalText(
                                text: "09:50 PM",
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
