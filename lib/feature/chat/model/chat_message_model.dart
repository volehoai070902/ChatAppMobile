class ChatMessageModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? createdAt;
  String get tableMessage => "table_message";
  
  ChatMessageModel({
    this.createdAt,
    this.id,
    this.message,
    this.receiverId,
    this.senderId
  });

  factory ChatMessageModel.fromJson({
    required Map<String, dynamic> map,
  }){
    return ChatMessageModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']).toString(),
      message: map['messageId'],
      receiverId: map['receiverId'],
      senderId: map['senderId']
    );
  }
}