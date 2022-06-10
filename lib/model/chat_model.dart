class ChatModel {
  late String dateTime;
  late String message;
  late String senderId;
  late String recieverId;

  ChatModel({
    required this.message,
    required this.senderId,
    required this.dateTime,
    required this.recieverId,
  });
  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'recieverId': recieverId,
      'senderId': senderId,
      'dateTime': dateTime,
    };
  }
}
