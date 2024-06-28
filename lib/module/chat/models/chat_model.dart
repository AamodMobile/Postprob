class ChatMessage {
  String messageContent;
  String messageType;
  bool isFile;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.isFile,
  });
}