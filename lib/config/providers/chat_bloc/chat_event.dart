
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInitialEvent extends ChatEvent {}

class ChatLoadingEvent extends ChatEvent {}

class ChatSuccessEvent extends ChatEvent {
  final String message;
  const ChatSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatErrorEvent extends ChatEvent {
  final String message;
  const ChatErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatMessageEvent extends ChatEvent {
  final String message;
  const ChatMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatSendMessageEvent extends ChatEvent {
  final String message;
  const ChatSendMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatDeleteAllMessagesEvent extends ChatEvent {}