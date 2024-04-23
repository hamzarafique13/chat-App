import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatAppProviderNotifierProvider =
    StateNotifierProvider<ChatAppProviderNotifier, ChatAppState>(
  (ref) => ChatAppProviderNotifier(),
);

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatAppState {
  final User? user;

  ChatAppState({this.user});
}

class ChatAppProviderNotifier extends StateNotifier<ChatAppState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatAppProviderNotifier() : super(ChatAppState());

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
