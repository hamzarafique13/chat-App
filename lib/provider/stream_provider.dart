import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/massagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider = StreamProvider.autoDispose
    .family<List<MassageModel>, ChatModel>((ref, chatroom) async* {
  yield* FirebaseFirestore.instance
      .collection("chatrooms")
      .doc(chatroom.chatroomid)
      .collection("massages")
      .orderBy("createdon", descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => MassageModel.fromJson(doc.data()))
        .toList();
  });
});
