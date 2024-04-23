import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/services/firebaseservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPageProvider =
    StateNotifierProvider<UserProviderNotifier, List<UserModel>>(
        (ref) => UserProviderNotifier([]));
// final fierstoredb = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final Firebaseservices _firebaseservices = Firebaseservices();

class UserProviderNotifier extends StateNotifier<List<UserModel>> {
  UserProviderNotifier(List<UserModel>? initialmovie)
      : super(initialmovie ?? []);

  void addUserToList(UserModel user) {
    state = [
      ...state,
      user,
    ];
    _firebaseservices.addPersonToFirebase(user);
  }

  void searchByTheName(String name) async {
    state = await _firebaseservices.searchByName(name);
  }

  Future<void> fetchUserTOFirebase() async {
    state = await _firebaseservices.fetchUserFromFirebase();
  }

  // Future<void> fetchChatRoom(UserModel userModel,UserModel otherUser) async {
  //   state = await _firebaseservices.getChatroomModel(otherUser, userModel);
  // }
}
