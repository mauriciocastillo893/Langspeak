import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/chat/chat_header_option/chat_header_option_primitive.dart';
import 'package:langspeak/ui/shared/chat/searcher/searcher_primitive.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
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
                    ChatHeaderOptionPrimitive(
                      iconDefault: Icons.chat_outlined,
                      iconDefaultSelected: Icons.chat,
                      text: 'Chats',
                      margin: const EdgeInsets.only(right: 10),
                      onPressed: () => _onSelected(0),
                      isSelected: _selectedIndex == 0,
                    ),
                    ChatHeaderOptionPrimitive(
                      iconDefault: Icons.groups_outlined,
                      iconDefaultSelected: Icons.groups,
                      text: 'Groups',
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      onPressed: () => _onSelected(1),
                      isSelected: _selectedIndex == 1,
                    ),
                    ChatHeaderOptionPrimitive(
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
                      child: SearcherPrimitive(
                        onSearch: _onSearch,
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      // color: Color.fromRGBO(0, 102, 146, 1),
                      color: Color.fromRGBO(21, 106, 142, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
