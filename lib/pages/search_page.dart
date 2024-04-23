import 'package:chat_app/services/helper/FirebaseHelper.dart';
import 'package:chat_app/model/chatmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/pages/chat_room.dart';
import 'package:chat_app/provider/profile_pic_provider.dart';
import 'package:chat_app/provider/searchstate_provider.dart';
import 'package:chat_app/services/firebaseservices.dart';

final searchboolProvider = StateProvider<bool>((ref) => false);

// final textFieltBoolProvider = StateProvider<bool>((ref) => false);

class SearchScreen extends ConsumerStatefulWidget {
  SearchScreen({
    required this.userModel,
    required this.firebaseUser,
  });

  UserModel userModel;
  final User firebaseUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  final firebaseAuth = Firebaseservices();
  late List<UserModel> userNameList;
  @override
  Widget build(BuildContext context) {
    final searchBoolState = ref.watch(searchboolProvider);
    if (searchBoolState == true) {
      userNameList = ref.watch(searchEmailprovider);
    } else {
      userNameList =
          ref.watch(searchBoolState ? searchEmailprovider : userPageProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Search')),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      ref.read(searchboolProvider.notifier).state = false;
                    },
                    icon: const Icon(Icons.clear, color: Colors.black),
                  ),
                  labelText: 'Search With Email',
                ),
                onChanged: (value) {
                  // ref.read(textFieltBoolProvider.notifier).state = true;
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                child: const Text('Search'),
                onPressed: () async {
                  final searchedMoviesData = await Firebaseservices()
                      .searchByName(searchController.text);
                  ref.read(searchEmailprovider.notifier).state =
                      searchedMoviesData;
                  ref.read(searchboolProvider.notifier).state = true;
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: userNameList.length,
                  itemBuilder: (context, index) {
                    var searchedUser = userNameList[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              NetworkImage(searchedUser.profilepic),
                        ),
                        title: Text(searchedUser.fullname),
                        subtitle: Text(searchedUser.email),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () async {
                          final firebaseservices = Firebaseservices();
                          final ChatModel chatroomodel = await firebaseservices
                              .getChatroomModel(searchedUser, widget.userModel);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ChatRoomScreen(
                                chatroom: chatroomodel,
                                otherUser: searchedUser,
                                userModel: widget.userModel,
                                firebaseuser: widget.firebaseUser,
                              );
                            }),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
