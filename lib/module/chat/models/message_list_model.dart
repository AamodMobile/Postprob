class MessageListModel {
  dynamic id;
  dynamic userId;
  dynamic recipientId;
  dynamic eventId;
  dynamic channelId;
  dynamic message;
  dynamic isRead;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isSender;
  dynamic time;

  MessageListModel({
    this.id,
    this.userId,
    this.recipientId,
    this.eventId,
    this.channelId,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.isSender,
    this.time,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) => MessageListModel(
        id: json["id"],
        userId: json["user_id"],
        recipientId: json["recipient_id"],
        eventId: json["event_id"],
        channelId: json["channel_id"],
        message: json["message"],
        isRead: json["is_read"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isSender: json["is_sender"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "recipient_id": recipientId,
        "event_id": eventId,
        "channel_id": channelId,
        "message": message,
        "is_read": isRead,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_sender": isSender,
        "time": time,
      };
}
