import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_state.dart';
import 'package:langspeak/ui/shared/chat/chat_cards/primitive_buble_chat.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/ai_array.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';
import 'package:langspeak/ui/shared/text_field/message_field_box.dart';

class PrimitiveAIChat extends StatelessWidget {
  const PrimitiveAIChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatInitialState) {
              return const Expanded(
                child: Center(
                  child: NormalText(
                    text: "Start a new chat with Sora",
                  ),
                ),
              );
            } else if (state is ChatLoadingState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ChatSuccessState ||
                state is ChatMessageState ||
                state is ChatSendMessageState) {
              return Expanded(
                child: ListView.builder(
                  controller: ChatBloc.chatScrollController,
                  itemCount: AiArray.messageList.length,
                  itemBuilder: (context, index) {
                    final message = AiArray.messageList[index];
                    return PrimitiveBubleChat(
                      index: index,
                      lengthArray: AiArray.messageList.length,
                      textToDisplay: message.text,
                      date: message.date,
                      whoSend: message.whoSend,
                    );
                  },
                ),
              );
            } else if (state is ChatErrorState) {
              return Expanded(
                child: Center(
                  child: NormalText(
                    text: "Error: ${state.message}",
                  ),
                ),
              );
            } else {
              return const Expanded(child: SizedBox());
            }
          },
        ),
        const MessageFieldBox()
      ],
    );
  }
}
