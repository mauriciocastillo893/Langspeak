
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChatState extends Equatable{
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState{}

class ChatLoadingState extends ChatState{}

class ChatSuccessState extends ChatState{
  final String message;
  const ChatSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatErrorState extends ChatState{
  final String message;
  const ChatErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatMessageState extends ChatState{
  final String message;
  const ChatMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatSendMessageState extends ChatState{
  final String message;
  const ChatSendMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatDeleteAllMessagesState extends ChatState{}