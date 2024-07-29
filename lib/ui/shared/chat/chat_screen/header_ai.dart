import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_event.dart';

class HeaderAI extends StatelessWidget {
  const HeaderAI({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.watch<ChatBloc>();
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(21, 106, 142, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.red,
            padding: const EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Text(
              'SORA AI',
              style: TextStyle(
                color: Color.fromRGBO(105, 201, 242, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.more_vert,
                    color: Color.fromRGBO(105, 201, 242, 1),
                  ),
                ),
                onSelected: (String result) {
                  if (result == 'delete') {
                    // Acción de borrar chat
                    // print("Borrar chat seleccionado");
                    chatBloc.add(ChatDeleteAllMessagesEvent());
                    // Aquí puedes añadir la funcionalidad para borrar el chat
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Borrar chat'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
