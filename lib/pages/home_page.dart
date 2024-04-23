import 'package:chat_app/log_in/log_in_page.dart';
import 'package:chat_app/services/helper/FirebaseHelper.dart';
import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/pages/chat_room.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/provider/home_stream_provider.dart';
import 'package:chat_app/provider/log_in_provider.dart';
import 'package:chat_app/provider/profile_pic_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen(
    this.user,
    this.firebaseuser, {
    super.key,
  });
  UserModel user;
  User firebaseuser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(userPageProvider.notifier).fetchUserTOFirebase();
    });
  }

  // int messageCount = 0;

  // // When a new message arrives
  // void onNewMessageReceived() {
  //   // Update the message count
  //   messageCount++;
  // }

  @override
  Widget build(BuildContext context) {
    final chatRooms = ref.watch(chatRoomsProvider(widget.user));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat App"),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(chatAppProviderNotifierProvider.notifier).logout();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: chatRooms.when(
            data: (chatRoomsData) {
              if (chatRoomsData.isEmpty) {
                return const Center(
                  child: Text("No Chats"),
                );
              }

              return ListView.builder(
                itemCount: chatRoomsData.length,
                itemBuilder: (context, index) {
                  ChatModel chatRoomModel =
                      ChatModel.fromJson(chatRoomsData[index].toJson());

                  Map<String, dynamic> participants =
                      chatRoomModel.participants;

                  List<String> participantKeys = participants.keys.toList();
                  participantKeys.remove(widget.user.id);

                  return FutureBuilder(
                    future: FirebaseHelper.getUserModelById(participantKeys[0]),
                    builder: (context, userData) {
                      if (userData.connectionState == ConnectionState.done) {
                        if (userData.data != null) {
                          UserModel targetUser = userData.data as UserModel;

                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChatRoomScreen(
                                    chatroom: chatRoomModel,
                                    firebaseuser: widget.firebaseuser,
                                    userModel: widget.user,
                                    otherUser: targetUser,
                                  );
                                }),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(targetUser.profilepic),
                            ),
                            title: Text(targetUser.fullname),
                            subtitle: (chatRoomModel.lastmassage != "")
                                ? Text(
                                    chatRoomModel.lastmassage,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "Say hi to your new friend!",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                            // trailing: Text(mas),
                            // trailing: Text(
                            //   '${index + 0}', // Display the message count
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineMedium!
                            //       .copyWith(
                            //         foreground: Paint()
                            //           ..style = PaintingStyle.stroke
                            //           ..color = const Color(0xff0296E5)
                            //           ..strokeWidth = 0.3,
                            //         fontFamily: 'Poppins',
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.w700,
                            //       ),
                            // ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => const Center(
              child: Text(
                  "An error occurred! Please check your internet connection."),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchScreen(
              userModel: widget.user,
              firebaseUser: widget.firebaseuser,
            );
          }));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
