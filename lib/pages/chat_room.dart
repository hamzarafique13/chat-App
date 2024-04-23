// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/massagemodel.dart';
import 'package:chat_app/provider/massage_provider.dart';
import 'package:chat_app/provider/stream_provider.dart';
import 'package:chat_app/services/firebaseservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chat_app/model/freezedusermodel.dart';
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({
    required this.otherUser,
    required this.chatroom,
    required this.userModel,
    required this.firebaseuser,
  });
  final UserModel otherUser;
  final ChatModel chatroom;
  final UserModel userModel;
  final User firebaseuser;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomState();
}

TextEditingController messageController = TextEditingController();

class _ChatRoomState extends ConsumerState<ChatRoomScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(massagePageProvider.notifier).fetchNewMassage(
            widget.chatroom,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatmessage = ref.watch(chatMessagesProvider(widget.chatroom));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                widget.otherUser.profilepic.toString(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.otherUser.fullname.toString())
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: chatmessage.when(
                  data: (chatMessagesData) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: chatMessagesData.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: (chatMessagesData[index].sender ==
                                  widget.userModel.id)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (chatMessagesData[index].sender ==
                                        widget.userModel.id)
                                    ? Colors.grey[200]
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(chatMessagesData[index].text),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => const Center(
                    child: Text(
                        "An error occurred! Please check your internet connection."),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Enter message'),
                      onTap: () {},
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final firebaseservices = Firebaseservices();
                      if (messageController.text.isNotEmpty) {
                        MassageModel massageModel = MassageModel(
                          massageid: const Uuid().v1(),
                          sender: widget.userModel.id,
                          text: messageController.text.trim(),
                          seen: false,
                          createdon: DateTime.now(),
                        );
                        messageController.clear();
                        firebaseservices.sendMessage(
                            widget.chatroom, massageModel);
                        ref
                            .read(massagePageProvider.notifier)
                            .fetchNewMassage(widget.chatroom);
                      }
                    },
                    icon: const Icon(Icons.send),
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
