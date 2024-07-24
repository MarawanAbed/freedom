class MessagesModel {
  final String? senderId;
  final String receiverId;
  final String? content;
  final DateTime? sendTime;
  final MessageType? messageType;

  MessagesModel({
    this.senderId,
    required this.receiverId,
    this.content,
    this.sendTime,
    this.messageType,
  });

  factory MessagesModel.fromJson(Object? json) {
    if (json == null) {
      // Handle null input if necessary
      throw ArgumentError('json cannot be null');
    }

    if (json is Map<String, dynamic>) {
      return MessagesModel(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        content: json["content"],
        sendTime: json["sendTime"]?.toDate(),
        messageType: MessageType.fromJson(json["messageType"]),
      );
    } else {
      throw ArgumentError('json must be a Map<String, dynamic>');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'sendTime': sendTime,
      'messageType': messageType?.toJson(),
    };
  }
}

enum MessageType {
  text,
  image;

  String toJson() => name;

  factory MessageType.fromJson(String json) => values.byName(json);
}
