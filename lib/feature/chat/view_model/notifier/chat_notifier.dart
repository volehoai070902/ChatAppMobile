import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:chatapp/feature/chat/repo/chat_repo.dart';
import 'package:flutter/material.dart';

class ChatNotifier extends ChangeNotifier{
  final _chatRepo = ChatRepository();

  Stream<List<UserModel>>? _userStream;
  Stream<List<UserModel>>? get userStream => _userStream;
  
  Stream<List<UserModel>> getUsers(){
    return _chatRepo.getUser();
  }

}