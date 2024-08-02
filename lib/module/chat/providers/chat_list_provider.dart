// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/chat_list_model.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatListProvider extends ChangeNotifier {
  var chatList = <ChatListModel>[];
  var messageList = <MessageListModel>[];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  PusherChannelsFlutter pusher = PusherChannelsFlutter();
  late PusherChannel myPrivateChannel;
  bool isChannelInitialized = false;
  String channelId = "";
  String eventId = "";
  String isBlock = "";
  String isMute = "";
  String otherUserId = "";
  int currentPage = 0;
  int totalPage = 0;
  bool hasMore = false;
  var files = [];
  var videos = [];
  var photos = [];
  TextEditingController msg = TextEditingController();
  File image = File("");
  File video = File("");
  String selectedFilePath = "";
  int? fileSize;
  DateTime? fileDate;
  bool isSelect = false;
  bool isVideo = false;
  var thumbPath;

  //VideoPlayerController? controller;
  void pickVideo(BuildContext context) async {
    var result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: false,
      dialogTitle: 'Select a Videos',
      type: FileType.video,
    );
    if (result != null) {
      var files = result.files;
      var file = files[0];
      int size = bytesToMB(file.size);
      if (size > 20) {
        if (context.mounted) {
          errorToast(context, "Video size should be less then 20 mb");
        }
      } else {
        videos.add(file);
        video = File(file.path!);
        isSelect = true;
        isVideo = true;
        // _initVideo();
        // thumbPath = await _getImage(file.path!);
        Log.console("Thumbnail path: $thumbPath");
        notifyListeners();
      }
    } else {
      if (context.mounted) {
        errorToast(context, "Video no pick");
      }
    }
  }

  /* Future<String?> _getImage(String videoUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    return thumbnailPath;
  }*/
  /* void _initVideo() async {
    */ /* if (controller != null) {
      controller!.removeListener(_videoControllerListener);
    }*/ /*

    if (isSelect == true) {
      controller = VideoPlayerController.file(File(video.path));

      await controller!.initialize();
      //controller!.addListener(_videoControllerListener);

      notifyListeners();
    }
  }*/

  int bytesToMB(int bytes) {
    if (bytes == 0) return 0;
    return (bytes / math.pow(1024, 2)).ceil();
  }

  Future<void> uploadPDFFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedFilePath = result.files.single.path.toString();
      files.add(result.files[0]);
      fileSize = File(selectedFilePath).lengthSync();
      fileDate = File(selectedFilePath).lastModifiedSync();
      notifyListeners();
    } else {
      if (context.mounted) {
        errorToast(context, "Not pick file");
      }
    }
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (hasMore) {
        if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange) {
          if (currentPage == totalPage) {
          } else {
            currentPage++;
            notifyListeners();
            getMessages(false, isFast: false);
          }
        }
        if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {}
      }
    });
  }

  void initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: "521f6611e9ba0643f298",
        cluster: "ap2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: channelId);
      await pusher.connect();
    } catch (e) {
      Log.console("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    Log.console("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    Log.console("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    Log.console("onEvent: $event");
    Log.console("Event received: $event");
    onNewMessage(event);
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    Log.console("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    Log.console("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    Log.console("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    Log.console("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    Log.console("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    Log.console("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    Log.console("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {"auth": "foo:bar", "channel_data": '{"user_id": 1}', "shared_secret": "foobar"};
  }

  void onTriggerEventPressed(Map<String, dynamic> jsonData) async {
    pusher.trigger(PusherEvent(channelName: channelId, eventName: eventId, data: jsonData));
  }

  void onNewMessage(dynamic event) {
    try {
      var data = json.decode(event.data);
      Log.console("Parsed data: $data");
      var newMessage = MessageListModel.fromJson(data["message"]);
      if (otherUserId == data["message"]["user_id"].toString()) {
        addMessage(newMessage);
        scrollToBottom();
      }
    } catch (e) {
      Log.console("Parsed data: $e");
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void scrollSmooth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.minScrollExtent-200);
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> chatListGet(BuildContext context, bool isLoad) async {
    try {
      isLoading = isLoad;
      var result = await ApiService.chatList();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          chatList.clear();
          isLoading = false;
          chatList = List<ChatListModel>.from(json["data"].map((i) => ChatListModel.fromJson(i))).toList(growable: true);
        } else {
          chatList.clear();
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      chatList.clear();
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  void addMessage(MessageListModel message) {
    try {
      Log.console("Message added: $message");
      messageList.add(message);
      notifyListeners();
    } catch (e) {
      Log.console("Message added: $e");
    }
  }

  Future<void> getMessages(bool load, {bool? isFast}) async {
    try {
      isLoading = load;
      var result = await ApiService.getMessages(otherUserId, currentPage.toString());
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        channelId = json["channel_id"];
        eventId = json["event_id"];
        isMute = json["is_mute"].toString();
        isBlock = json["is_block"].toString();
        totalPage = int.parse(json["total_pages"].toString());
        Log.console("totalPage$totalPage");
        Log.console("channelId$channelId");
        Log.console("eventId$eventId");
        if (isFast != null) {
          if (isFast) {
            messageList.clear();
            messageList.addAll(List<MessageListModel>.from(json["data"]["data"].map((i) => MessageListModel.fromJson(i))).toList(growable: true));
            scrollToBottom();
            hasMore = true;
          } else {
            messageList.insertAll(0, List<MessageListModel>.from(json["data"]["data"].map((i) => MessageListModel.fromJson(i))).toList(growable: true));
            scrollSmooth();
          }
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> sendMessagePusher(BuildContext context, String msg, String recipientId, String userId) async {
    try {
      currentPage = 1;
      if (context.mounted) {
        final Map<String, dynamic> jsonData = {
          "user_id": userId,
          "recipient_id": recipientId,
          "message": msg,
        };
        onTriggerEventPressed(jsonData);
        getMessages(false, isFast: true);
        chatListGet(context, false);
      } else {
        errorToast(context, "Error send msg");
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> sendMessage(BuildContext context, String message) async {
    try {
      var result = await ApiService.sendMessage(message, otherUserId, eventId, channelId, files, videos, photos);
      if (context.mounted) {
        if (result["status"] == true) {
          msg.text = "";
          files.clear();
          videos.clear();
          photos.clear();
          /* final Map<String, dynamic> jsonData = {
            "user_id": json["data"]["user_id"],
            "recipient_id": json["data"]["recipient_id"],
            "message": json["data"]["message"],
            "created_at": json["data"]["created_at"],
            "updated_at": json["data"]["updated_at"],
            "id": json["data"]["id"],
          };*/
          getMessages(false, isFast: true);
          scrollToBottom();
          chatListGet(context, false);
        } else {
          errorToast(context, result["message"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> clearAllMessages(BuildContext context, String eventId) async {
    try {
      var result = await ApiService.clearAllMessages(eventId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          chatListGet(context, false);
          messageList.clear();
          //getMessages(false,isFast: true);
        } else {
          //errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> readAllMessages(BuildContext context, String eventId) async {
    try {
      var result = await ApiService.readAllMessages(eventId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          chatListGet(context, false);
        } else {
          //errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> muteChat(BuildContext context, String isMute) async {
    try {
      currentPage = 1;
      showProgress(context);
      var result = await ApiService.muteChat(channelId, otherUserId, isMute);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          successToast(context, json["message"].toString());
          chatListGet(context, false);
          getMessages(false, isFast: true);
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> blockChat(BuildContext context, String isBlock) async {
    try {
      currentPage = 1;
      showProgress(context);
      var result = await ApiService.blockChat(channelId, otherUserId, isBlock);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          successToast(context, json["message"].toString());
          chatListGet(context, false);
          getMessages(false, isFast: true);
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }
}
