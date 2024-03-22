import 'package:chatapp/feature/authentication/models/auth_result.dart';
import 'package:chatapp/feature/authentication/models/auth_state.dart';
import 'package:chatapp/feature/authentication/repo/auth_service.dart';
import 'package:flutter/material.dart';

class AuthChangeNotifier extends ChangeNotifier{
  int _count = 42;
  int get count => _count;
  String? get displayName => _authenticator.displayName;
  String? get exceptionMessage => _authenticator.exceptionMessage;
  bool? get isExpired => _authenticator.isExpired;
  final _authenticator = Authenticator();
  AuthState authState = AuthState.unknown();
  AuthChangeNotifier(){
    if(_authenticator.isAlreadyLoggedIn){
      authState = AuthState(result: AuthResult.success, isLoading: false, userId: _authenticator.userId);
      notifyListeners();
    }
  }

  void Test(){
    authState = authState.copiedWithIsLoading(true);
    notifyListeners();
  }

  Future<void> logOut()async{
    authState = authState.copiedWithIsLoading(true);
    await _authenticator.logOut();
    authState = AuthState.unknown();
    
    notifyListeners();
  }

  Future<void> signInWithPassword({required String email, required String password}) async{
    authState = authState.copiedWithIsLoading(true);
    final result = await _authenticator.signInWithPassword(email: email, password: password);
    final userId = _authenticator.userId;

    authState = AuthState(result: result, isLoading: false, userId: userId, );
    notifyListeners();
  }

  Future<void> signUpWithPassword(
    {
      required String email,
      required String password,
      required String username,
    }
  )async{
    
    authState = authState.copiedWithIsLoading(true);
    final result = await _authenticator.signUpWithPassword(email: email.trim(), password: password.trim(), username: username.trim());
    
    if (result.user != null){
      _authenticator.onSaveUserInf(result.user);
    }
    notifyListeners();
  }


  Future<void> refreshSessions() async{
    notifyListeners();
  }
}