class AiArray {
  static List<AiModel> messageList = [
    // AiModel(
    //     whoSend: WhoSend.me, date: DateTime.now(), text: "Hi, how are you?"),
    // AiModel(whoSend: WhoSend.ai, date: DateTime.now(), text: "Morning!!"),
    // AiModel(whoSend: WhoSend.me, date: DateTime.now(), text: "Hiii!!"),
    // AiModel(
    //     whoSend: WhoSend.me,
    //     date: DateTime.now(),
    //     text:
    //         "Testeando los messageList todos todsoas dawdwa ds dawd aw daw dwad aw dsdas dwd w"),
  ];
}

class AiModel {
  final WhoSend whoSend;
  final DateTime date;
  final String text;

  AiModel({
    required this.whoSend,
    required this.date,
    required this.text,
  });
}

enum WhoSend {
  me,
  ai,
}
