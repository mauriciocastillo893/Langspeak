import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_event.dart';
import 'package:langspeak/config/providers/chat_bloc/chat_state.dart';
import 'package:langspeak/infrastructure/helpers/open_ai/open_ai_services.dart';
import 'package:langspeak/ui/shared/chat/chat_screen/ai_array.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static final ScrollController chatScrollController = ScrollController();

  ChatBloc() : super(ChatInitialState()) {
    on<ChatInitialEvent>(_onChatInitial);
    on<ChatLoadingEvent>(_onChatLoading);
    on<ChatSuccessEvent>(_onChatSuccess);
    on<ChatErrorEvent>(_onChatError);
    on<ChatMessageEvent>(_onChatMessage);
    on<ChatSendMessageEvent>(_onChatSendMessage);
    on<ChatDeleteAllMessagesEvent>(_onChatDeleteAllMessagesEvent);
  }

  Future<void> _onChatInitial(
      ChatInitialEvent event, Emitter<ChatState> emit) async {
    final messages = AiArray.messageList;
    if (messages.isEmpty) {
      emit(ChatInitialState());
    } else {
      emit(ChatSuccessState(message: messages.last.text));
    }
  }

  Future<void> _onChatLoading(
      ChatLoadingEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
  }

  Future<void> _onChatSuccess(
      ChatSuccessEvent event, Emitter<ChatState> emit) async {
    emit(ChatSuccessState(message: event.message));
  }

  Future<void> _onChatError(
      ChatErrorEvent event, Emitter<ChatState> emit) async {
    emit(ChatErrorState(message: event.message));
  }

  Future<void> _onChatMessage(
      ChatMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatMessageState(message: event.message));
  }

  Future<void> _onChatSendMessage(
      ChatSendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatSendMessageState(message: event.message));
    AiArray.messageList.add(
      AiModel(
        text: event.message,
        date: DateTime.now(),
        whoSend: WhoSend.me,
      ),
    );
    emit(ChatLoadingState());
    try {
      final result = await sendTextCompletionRequest(event.message);
      print("Result : ${result}");
      AiArray.messageList.add(
        AiModel(
          text: result,
          date: DateTime.now(),
          whoSend: WhoSend.ai,
        ),
      );
      emit(ChatSuccessState(message: result));
    } catch (e) {
      emit(ChatErrorState(message: e.toString()));
    }
    moveScrollToBottom();
  }

  Future<void> _onChatDeleteAllMessagesEvent(
      ChatDeleteAllMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatDeleteAllMessagesState());
    AiArray.messageList.clear();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
