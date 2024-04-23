import 'dart:math';

import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/model/massagemodel.dart';
import 'package:chat_app/pages/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Firebaseservices {
  final _fierstoredb = FirebaseFirestore.instance;
  final String _personcollection = 'users';
  final String _chatcollection = 'chatrooms';
  final String _massagecollection = 'massages';

  Future<void> addPersonToFirebase(UserModel user) async {
    try {
      await _fierstoredb
          .collection(_personcollection)
          .doc(user.id)
          .set(user.toJson());
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<List<UserModel>> fetchUserFromFirebase() async {
    try {
      List<UserModel> user = [];
      var snapshot = await _fierstoredb.collection(_personcollection).get();
      for (var data in snapshot.docs) {
        user.add(UserModel.fromJson(data.data()));
      }
      return user;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserModel>> searchByName(String email) async {
    final result = await _fierstoredb
        .collection(_personcollection)
        .where('email', isEqualTo: email)
        .get();

    final searchResultList =
        result.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

    return searchResultList;
  }

  Future<ChatModel> getChatroomModel(
      UserModel otherUser, UserModel userModel) async {
    ChatModel chatroom;
    QuerySnapshot snapshot = await _fierstoredb
        .collection(_chatcollection)
        .where('participants.${userModel.id}', isEqualTo: true)
        .where('participants.${otherUser.id}', isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatModel existingChatroom =
          ChatModel.fromJson(docData as Map<String, dynamic>);
      chatroom = existingChatroom;
      print('chatroom Already created!');
    } else {
      ChatModel newchatroom = ChatModel(
          chatroomid: const Uuid().v1(),
          participants: {
            userModel.id.toString(): true,
            otherUser.id.toString(): true,
          },
          lastmassage: '');
      await _fierstoredb
          .collection(_chatcollection)
          .doc(newchatroom.chatroomid)
          .set(newchatroom.toJson());
      chatroom = newchatroom;
      print('create new chatroom!');
    }
    return Future.value(chatroom);
  }

  Future<void> sendMessage(
    ChatModel chatroom,
    MassageModel newMesssage,
  ) async {
    try {
      // Save the new message in the messages collection
      await FirebaseFirestore.instance
          .collection(_chatcollection)
          .doc(chatroom.chatroomid)
          .collection(_massagecollection)
          .doc(newMesssage.massageid)
          .set(newMesssage.toJson());

      // last message
      await FirebaseFirestore.instance
          .collection(_chatcollection)
          .doc(chatroom.chatroomid)
          .update({"lastmassage": newMesssage.text});

      print("Message Sent!");
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Future<List<MassageModel>> featchMassagesToFirebase(
      ChatModel chatModel) async {
    try {
      List<MassageModel> massage = [];
      var snapshot = await _fierstoredb
          .collection(_chatcollection)
          .doc(chatModel.chatroomid)
          .collection(_massagecollection)
          .orderBy('createdon', descending: true)
          .get();
      for (var data in snapshot.docs) {
        massage.add(
          MassageModel.fromJson(
            data.data(),
          ),
        );
      }
      return massage;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<User>> fetchData(
      UserModel userModel, TextEditingController searchController) async {
    List<User> user = [];
    await _fierstoredb
        .collection("users")
        .where("email", isEqualTo: searchController.text)
        .where("email", isNotEqualTo: userModel.email)
        .snapshots();
    return user;
  }

  Future<void> chatMessage(ChatModel chatroom) async {
    await _fierstoredb
        .collection(_chatcollection)
        .doc(chatroom.chatroomid)
        .collection(_massagecollection)
        .orderBy("createdon", descending: true)
        .snapshots();
  }
}
