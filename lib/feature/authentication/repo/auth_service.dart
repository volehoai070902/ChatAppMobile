import 'package:chatapp/feature/authentication/models/auth_result.dart';
import 'package:chatapp/feature/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authenticator{
  final supabase = Supabase.instance.client;
  String? get userId => supabase.auth.currentUser?.id;
  bool get isAlreadyLoggedIn => userId != null;
  String? get displayName => supabase.auth.currentUser?.userMetadata?["username"] ?? '';
  String? _exceptionMessage = '';
  String? get exceptionMessage => _exceptionMessage;
  Future<void> logOut () async{
    
    await supabase.auth.signOut();
  }

  Future<AuthResponse> signUpWithPassword({required String email, required  password,required String username}) async{
    
    try{
      final user = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username
        }
      );

      if (user.user == null){
        throw FlutterError("Signup failed");
      }else{
        onSaveUserInf(user.user);
      }
      return user;
    }
    catch (error){
      print(error.toString());
      return AuthResponse();
    }
  }

  Future<AuthResult> signInWithPassword({required String email, required  password}) async{
    try{
      final user = await supabase.auth.signInWithPassword(
        email: email,
        password: password);
      
      if (user.user == null){
        throw FlutterError("Signup failed");
      }
      return AuthResult.success;
    }on AuthException catch (error){
      print(error.toString());
      _exceptionMessage = error.message ;
      return AuthResult.failure;
    }
  }

  void onSaveUserInf(User? user) async{
    UserModel userModel = UserModel(
      email: user?.email,
      id: user?.id,
      username:user?.userMetadata?["username"],
    );

    await supabase.rest.from(userModel.tableName).insert({
        "email": userModel.email,
        "id":userModel.id,
        "username":user?.userMetadata?["username"]
    });
  }
}