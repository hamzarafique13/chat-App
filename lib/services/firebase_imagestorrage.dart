import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FireStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImage(Uint8List imageBytes, String imageName) async {
    try {
      final Reference storageRef = _storage.ref().child('Files/$imageName');
      final UploadTask uploadTask = storageRef.putData(imageBytes);
      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}
