class MessageList {
  bool? status;
  String? message;
  MessageListModelData? data;
  String? channelId;
  String? eventId;
  int? totalPages;
  dynamic isMute;
  dynamic isBlock;

  MessageList({
    this.status,
    this.message,
    this.data,
    this.channelId,
    this.eventId,
    this.totalPages,
    this.isMute,
    this.isBlock,
  });

  factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : MessageListModelData.fromJson(json["data"]),
        channelId: json["channel_id"],
        eventId: json["event_id"],
        totalPages: json["total_pages"],
        isMute: json["is_mute"],
        isBlock: json["is_block"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "channel_id": channelId,
        "event_id": eventId,
        "total_pages": totalPages,
        "is_mute": isMute,
        "is_block": isBlock,
      };
}

class MessageListModelData {
  int? currentPage;
  List<MessageListModel>? data;
  dynamic firstPageUrl;
  int? from;
  int? lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MessageListModelData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MessageListModelData.fromJson(Map<String, dynamic> json) => MessageListModelData(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<MessageListModel>.from(json["data"]!.map((x) => MessageListModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class MessageListModel {
  dynamic userId;
  dynamic recipientId;
  dynamic channelId;
  dynamic eventId;
  List<String>? filePath;
  String? message;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;
  dynamic isRead;
  dynamic isSender;
  String? time;

  MessageListModel({
    this.userId,
    this.recipientId,
    this.channelId,
    this.eventId,
    this.filePath,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.isRead,
    this.isSender,
    this.time,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) => MessageListModel(
        userId: json["user_id"],
        recipientId: json["recipient_id"],
        channelId: json["channel_id"],
        eventId: json["event_id"],
        filePath: json["file_path"] == null ? [] : List<String>.from(json["file_path"]!.map((x) => x)),
        message: json["message"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        isRead: json["is_read"],
        isSender: json["is_sender"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "recipient_id": recipientId,
        "channel_id": channelId,
        "event_id": eventId,
        "file_path": filePath == null ? [] : List<dynamic>.from(filePath!.map((x) => x)),
        "message": message,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "is_read": isRead,
        "is_sender": isSender,
        "time": time,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
