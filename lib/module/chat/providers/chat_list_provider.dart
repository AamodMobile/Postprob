import 'dart:async';
import 'dart:convert';

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
  String otherUserId = "";

  void initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: "1dd42ee25cd6c4a2c6ba",
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
      }
      scrollToBottom();
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

  Future<void> getMessages(BuildContext context, String recipientId, bool load) async {
    try {
      isLoading = load;
      var result = await ApiService.getMessages(recipientId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          isLoading = false;
          channelId = json["channel_id"];
          eventId = json["event_id"];
          messageList = List<MessageListModel>.from(json["data"].map((i) => MessageListModel.fromJson(i))).toList(growable: true);
        } else {
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> sendMessagePusher(BuildContext context, String msg, String recipientId, String userId) async {
    try {
      if (context.mounted) {
        final Map<String, dynamic> jsonData = {
          "user_id": userId,
          "recipient_id": recipientId,
          "message": msg,
        };
        onTriggerEventPressed(jsonData);
        getMessages(context, recipientId, false);
        chatListGet(context, false);
      } else {
        errorToast(context, "Error send msg");
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> sendMessage(BuildContext context, String msg, String recipientId) async {
    try {
      var result = await ApiService.sendMessage(msg, recipientId, eventId, channelId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          /* final Map<String, dynamic> jsonData = {
            "user_id": json["data"]["user_id"],
            "recipient_id": json["data"]["recipient_id"],
            "message": json["data"]["message"],
            "created_at": json["data"]["created_at"],
            "updated_at": json["data"]["updated_at"],
            "id": json["data"]["id"],
          };*/
          getMessages(context, recipientId, false);
          chatListGet(context, false);
        } else {
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }
}
