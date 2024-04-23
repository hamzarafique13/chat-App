import 'dart:io';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final imageProvider =
    StateNotifierProvider<ImagepickerNotifier, Uint8List?>((ref) {
  return ImagepickerNotifier();
});

final imagepickerprovider = StateProvider<List<UserModel>>(
  (ref) => [],
);

class ImagepickerNotifier extends StateNotifier<Uint8List?> {
  ImagepickerNotifier() : super(null);

  void updateSelectedImage(Uint8List file) {
    state = file;
  }

  void resetstate() {
    state = null;
  }

  Future<void> imagePicker() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ],
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (result != null) {
      if (!kIsWeb) {
        final studentProfilePic = result.files.first;
        Uint8List imageData = await File(studentProfilePic.path!).readAsBytes();
        updateSelectedImage(imageData);
      } else {
        final image = result.files.first.bytes;
        updateSelectedImage(image!);
      }
    }
  }
}
