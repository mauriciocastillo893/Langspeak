import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_event.dart';

class MessageFieldBox extends StatelessWidget {
  // Es de tipo ValueChanged<String> porque es una función que recibe un string
  // ValueChanged es un tipo de función que recibe un valor y no retorna nada
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, this.onValue = _defaultOnValue});

  static void _defaultOnValue(String value) {}

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.watch<ChatBloc>();
    // Este es un elemento que nos va a dar un control del input del cual vamos a asociar
    final textController = TextEditingController();
    // Este es un elemento que nos va a dar un control del focus del input del cual vamos a asociar
    final focusNode = FocusNode();

    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Escribe un mensaje',
      filled: true,
      enabledBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      fillColor: const Color.fromRGBO(12, 78, 107, 1),
      hintStyle: const TextStyle(color: Colors.white),
      focusedBorder: outlineInputBorder,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined, color: Colors.white),
        onPressed: () {
          final textValue = textController.value.text;
          // onValue(textValue);
          if (textValue.isEmpty) {
            return;
          }
          chatBloc.add(ChatSendMessageEvent(message: textValue));
          textController.clear();
        },
      ),
    );

    return SizedBox(
      height: 46,
      child: TextFormField(
        // Cuando se toca fuera del campo de texto, el foco se pierde
        onTapOutside: (event) {
          focusNode.unfocus();
        },
        focusNode: focusNode,
        controller: textController,
        decoration: inputDecoration,
        style: const TextStyle(color: Colors.white),
        onFieldSubmitted: (value) {
          // onValue(value);
          if (value.isEmpty) {
            return;
          }
          chatBloc.add(ChatSendMessageEvent(message: value));
          // Esto es para limpiar el campo de texto
          textController.clear();
          // Después que se limpia, el foco se mantiene en el campo de texto
          focusNode.requestFocus();
        },
        // onChanged: (value) {
        //   print('Changed: $value');
        // },
      ),
    );
  }
}
