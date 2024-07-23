import 'package:langspeak/domain/models/message_model/message_model.dart';

class SimulatedArray {
  static List<MessageModel> messageList = [
    MessageModel(
        whoSendId: "1234",
        whoSendName: "Adhara Castillo",
        date: DateTime.now(),
        text: "Hi, how are you?"),
    MessageModel(
        whoSendId: "1234",
        whoSendName: "Melissa Castillo",
        date: DateTime.now(),
        text: "Morning!!"),
    MessageModel(
        whoSendId: "1234",
        whoSendName: "Kristell Mateos",
        date: DateTime.now(),
        text: "Hiii!!"),
  ];
}
