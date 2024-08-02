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
  dynamic id;
  dynamic userId;
  dynamic recipientId;
  dynamic eventId;
  dynamic channelId;
  String? message;
  List<String>? filePath;
  List<String>? photos;
  List<String>? videos;
  dynamic fileType;
  dynamic isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  dynamic isSender;
  String? time;

  MessageListModel({
    this.id,
    this.userId,
    this.recipientId,
    this.eventId,
    this.channelId,
    this.message,
    this.filePath,
    this.photos,
    this.videos,
    this.fileType,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
    filePath: json["file_path"] == null ? [] : List<String>.from(json["file_path"]!.map((x) => x)),
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
    fileType: json["file_type"],
    isRead: json["is_read"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
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
    "file_path": filePath == null ? [] : List<dynamic>.from(filePath!.map((x) => x)),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
    "file_type": fileType,
    "is_read": isRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
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
