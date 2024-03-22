import 'dart:async';

import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:chatapp/feature/chat/model/chat_message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository {
  final supabase = Supabase.instance.client;

  Stream<List<UserModel>> getUserChanges() {
    final controller = StreamController<List<UserModel>>.broadcast();
    final id = supabase.auth.currentUser?.id;

    if (id == null) {
      throw Exception("user doesn't login yet");
    }

    supabase.from(UserModel().tableName).stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        final mData = data.map((e) => UserModel.fromJson(e)).toList();

        mData.removeWhere((element) {
          if (element.id?.trim().compareTo(id.trim()) == 0) {
            return true;
          } else {
            return false;
          }
        });
        controller.sink.add(mData);
      },
      onDone: () async {
        await controller.close();
      },
    );
    return controller.stream;
  }

  Future<void> sendMessage({required Map<String, dynamic>  json}) async {
    await supabase.from(ChatMessageModel().tableMessage).insert({
      "senderid": json["senderid"],
      "receiverid":json['receiverid'],
      "message":json['message'],
      "created_at": json['created_at'],
      "updated_at":json['updated_at']
    });
  }

  Future<void> refreshSession() async {
    await supabase.auth.refreshSession();
  }
}
