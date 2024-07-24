

class ChatListModel {
  int? id;
  String? userId;
  String? recipientId;
  String? channelId;
  String? eventId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? messageCount;
  int? unreadCount;
  String? message;
  Recipient? recipient;

  ChatListModel({
    this.id,
    this.userId,
    this.recipientId,
    this.channelId,
    this.eventId,
    this.createdAt,
    this.updatedAt,
    this.messageCount,
    this.unreadCount,
    this.message,
    this.recipient,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
    id: json["id"],
    userId: json["user_id"],
    recipientId: json["recipient_id"],
    channelId: json["channel_id"],
    eventId: json["event_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    messageCount: json["messageCount"],
    unreadCount: json["unreadCount"],
    message: json["message"],
    recipient: json["recipient"] == null ? null : Recipient.fromJson(json["recipient"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "recipient_id": recipientId,
    "channel_id": channelId,
    "event_id": eventId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "messageCount": messageCount,
    "unreadCount": unreadCount,
    "message": message,
    "recipient": recipient?.toJson(),
  };
}
class Recipient {
  int? id;
  String? name;
  String? image;
  String? time;

  Recipient({
    this.id,
    this.name,
    this.image,
    this.time,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    id: json["id"],
    name: json["name"],
    image: json["image"]??"",
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "time": time,
  };
}