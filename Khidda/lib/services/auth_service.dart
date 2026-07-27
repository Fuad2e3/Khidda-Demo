import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  // Use a getter to avoid calling instance before app is ready or if it fails
  FirebaseAuth? get _auth {
    try {
      if (Firebase.apps.isNotEmpty) {
        return FirebaseAuth.instance;
      }
    } catch (e) {
      debugPrint("Auth instance error: $e");
    }
    return null;
  }

  // Stream of user changes
  Stream<User?> get user => _auth?.authStateChanges() ?? const Stream.empty();

  // Sign in with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final auth = _auth;
      if (auth == null) return null;
      return await auth.signInWithEmailAndPassword(email: email, password: password).timeout(const Duration(seconds: 10));
    } catch (e) {
      debugPrint("Login error: $e");
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> register(String email, String password) async {
    try {
      final auth = _auth;
      if (auth == null) return null;
      return await auth.createUserWithEmailAndPassword(email: email, password: password).timeout(const Duration(seconds: 10));
    } catch (e) {
      debugPrint("Registration error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth?.signOut();
  }
}
