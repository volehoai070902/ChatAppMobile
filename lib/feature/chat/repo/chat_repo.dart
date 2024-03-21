import 'dart:async';

import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository {
  final _supabase = Supabase.instance.client;

  Stream<List<UserModel>> getUser() {
    final controller = StreamController<List<UserModel>>.broadcast();
    final id = _supabase.auth.currentUser?.id;
    
    if (id == null){
      throw Exception("user doesn't login yet");
    }

    _supabase.from(UserModel().tableName).stream(primaryKey: ['id']).listen((it) {
      print("Listen Hello");
      final mData = it.map((e) => UserModel.fromJson(e)).toList();
      mData.removeWhere((element) {
        if (element.id?.trim().compareTo(id.trim()) == 0){
          return true;
        }else{
          return false;
        }
    });

      controller
      ..sink
      ..add(mData);
     },onDone: () {
       controller.close();
     },);

     return controller.stream;
  }

  
}