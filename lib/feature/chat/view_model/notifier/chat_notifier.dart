import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:chatapp/feature/chat/model/chat_message_model.dart';
import 'package:chatapp/feature/chat/repo/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatNotifier extends ChangeNotifier{
  final _chatRepo = ChatRepository();

  Stream<List<UserModel>>? _userStream;
  Stream<List<UserModel>>? get userStream => _userStream;
  
  Future<void> getUsers() async  {
    _userStream = _chatRepo.getUserChanges();
    notifyListeners();
  }

  SupabaseStreamFilterBuilder listenMessage(String senderId){
    print(senderId);
    _chatRepo.supabase.channel("table_message_test").onPostgresChanges
    (
      event: PostgresChangeEvent.all,
      schema: "public",
      table: "table_message",
     callback: (payload) {
    },).subscribe();

    return _chatRepo.supabase.from("table_message").stream(primaryKey: ['id']);
  }


  Future<void> sendMessage(Map<String, dynamic> json)async{
    await _chatRepo.sendMessage(json: json);
    notifyListeners();
  }
}