import 'package:chatapp/feature/authentication/models/auth_result.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@immutable
class AuthState{
  final AuthResult? result;
  final bool isLoading;
  final String? userId;
  final AuthException? authException;
  const AuthState(
    {
      required this.result,
      required this.isLoading,
      required this.userId,
      this.authException
    }
  );

  const AuthState.unknown():result = null, isLoading = false, userId = null, authException = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(result: result, isLoading: isLoading, userId: userId);
  AuthState copiedWithException(AuthException exception) =>AuthState(authException: exception,result: result, isLoading: isLoading, userId: userId);

  @override
  bool operator== (covariant AuthState other) => identical(this, other) || (result == other.result && isLoading == other.isLoading && userId == other.userId);

  @override
  int get hashCode {
    return Object.hash(result, isLoading, userId);
  }
}