import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/model/massagemodel.dart';
import 'package:chat_app/pages/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRoomsProvider =
    StreamProvider.autoDispose.family<List<ChatModel>, UserModel>((ref, user) async* {
  // final userModel = ref.read(userModelProvider); // Assuming you have userModelProvider

  yield* FirebaseFirestore.instance
      .collection("chatrooms")
      .where("participants.${user.id}", isEqualTo: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ChatModel.fromJson(data);
    }).toList();
  });
});
