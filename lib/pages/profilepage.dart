import 'dart:io';

import 'package:chat_app/pages/helper/UIHelper.dart';
import 'package:chat_app/services/firebase_imagestorrage.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/provider/image_picker_provider.dart';
import 'package:chat_app/provider/profile_pic_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

final imageprofileProvider = StateProvider<File?>((ref) => null);

// ignore: must_be_immutable
class ProfileScreen extends ConsumerStatefulWidget {
  ProfileScreen(
    this.firebase,
    this.userModel, {
    super.key,
  });
  UserModel userModel;
  User firebase;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfileScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  void cropImage(File file, ref) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    if (croppedImage != null) {
      ref.read(imageprofileProvider).state = File(croppedImage.path);
    }
  }

  void imagePickerOption() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 250,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      await ref.read(imageProvider.notifier).imagePicker();
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.pop(context);
                        await ref.read(imageProvider.notifier).imagePicker();
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Get.back();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValues() {
    String fullname = namecontroller.text.trim();

    if (fullname.isEmpty) {
      print("Please fill all the fields");
      UIHelper.showAlertDialog(context, "Incomplete Data",
          "Please fill all the fields and upload a profile picture");
    } else {
      print("Uploading data..");
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageStorage = ref.watch(imageProvider);
    // List<UserModel> person = ref.watch(userPageProvider);
    // List<UserModel> imagepicker = ref.watch(imagepickerprovider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Your Profile'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(children: [
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                imagePickerOption();
              },
              padding: const EdgeInsets.all(0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imageStorage != null
                    ? Image.memory(imageStorage,
                            height: 300, width: 200, fit: BoxFit.cover)
                        .image
                    : const NetworkImage(''),
                child: imageStorage != null
                    ? null
                    : const Icon(
                        Icons.person,
                        size: 60,
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () async {
                await buildShowDialog(context);
                final firebasestorage = FireStorageService();
                var randomid = const Uuid().v1();

                final imageurl =
                    await firebasestorage.uploadImage(imageStorage!, randomid);
                UserModel user = UserModel(
                  fullname: namecontroller.text,
                  profilepic: imageurl,
                  email: widget.userModel.email,
                  id: widget.userModel.id.isEmpty
                      ? const Uuid().v1()
                      : widget.userModel.id,
                );
                ref.read(userPageProvider.notifier).addUserToList(user);

                final currentUser = FirebaseAuth.instance.currentUser;

                Navigator.popUntil(context, (route) => route.isFirst);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      user,
                      currentUser!,
                    ),
                  ),
                );
                checkValues();
                ref.read(imageProvider.notifier).resetstate();
              },
              color: Theme.of(context).colorScheme.secondary,
              child: const Text('Submit'),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<void> buildShowDialog(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 8), () {
          Navigator.pop(context);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
