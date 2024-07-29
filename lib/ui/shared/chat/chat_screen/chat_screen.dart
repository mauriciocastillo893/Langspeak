import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/chat/chat_cards/primitive_ai_chat.dart';
import 'package:langspeak/ui/shared/chat/chat_cards/primitive_group_chat.dart';
import 'package:langspeak/ui/shared/chat/chat_header_option/primitive_chat_header_option.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/header_ai.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/simulated_array.dart';
import 'package:langspeak/ui/shared/chat/chat_cards/primitive_person_chat.dart';
import 'package:langspeak/ui/shared/chat/searcher/primitive_searcher.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  final ValueChanged<int> function;

  const ChatScreen({super.key, required this.index, required this.function});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.function(index);
  }

  void _onSearch(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(28, 156, 184, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                child: Row(
                  children: [
                    PrimitiveChatHeaderOption(
                      iconDefault: Icons.chat_outlined,
                      iconDefaultSelected: Icons.chat,
                      text: 'Chats',
                      margin: const EdgeInsets.only(right: 10),
                      onPressed: () => _onSelected(0),
                      isSelected: _selectedIndex == 0,
                    ),
                    // PrimitiveChatHeaderOption(
                    //   iconDefault: Icons.groups_outlined,
                    //   iconDefaultSelected: Icons.groups,
                    //   text: 'Groups',
                    //   margin: const EdgeInsets.only(right: 5, left: 5),
                    //   onPressed: () => _onSelected(1),
                    //   isSelected: _selectedIndex == 1,
                    // ),
                    PrimitiveChatHeaderOption(
                      iconDefault: Icons.memory_outlined,
                      iconDefaultSelected: Icons.memory,
                      text: 'IA Chat',
                      margin: const EdgeInsets.only(left: 10),
                      onPressed: () => _onSelected(2),
                      isSelected: _selectedIndex == 2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.18,
                  child: FractionallySizedBox(
                      heightFactor: 0.6,
                      widthFactor: 1,
                      child: _selectedIndex != 2
                          ? PrimitiveSearcher(
                              onSearch: _onSearch,
                              isEnabled: _selectedIndex == 0,
                            )
                          : const HeaderAI())),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 102, 146, 1),
                      // color: Color.fromRGBO(21, 106, 142, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: FractionallySizedBox(
                        widthFactor: 0.98,
                        heightFactor: 0.98,
                        child: _selectedIndex == 0
                            ? PrimitivePersonChat(
                                arrayToDisplay: SimulatedArray.messageList,
                              )
                            : _selectedIndex == 1
                                ? const PrimitiveGroupChat(arrayToDisplay: [])
                                : const PrimitiveAIChat()),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
