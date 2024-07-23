// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  final String? whoSendId;
  final String? whoSendName;
  final String? text;
  final String? audio;
  final DateTime date;

  MessageModel({
    this.whoSendId,
    this.whoSendName,
    this.text,
    this.audio,
    required this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        whoSendId: json["who_send"],
        whoSendName: json["who_send_name"],
        text: json["text"],
        audio: json["audio"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "who_send_id": whoSendId,
        "who_send_name": whoSendName,
        "text": text,
        "audio": audio,
        "date": date,
      };
}
