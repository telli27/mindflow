import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child("ArticleImages")
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask;

    return await storageRef.ref.getDownloadURL();
  }
    Future<String> uploadProfilMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child("UserImages")
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask;

    return await storageRef.ref.getDownloadURL();
  }
  Future<String> updateProfileMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child("profileMedia")
        .child("${_auth.currentUser!.uid}_profileImage.jpg")
        .putFile(file);
    uploadTask.snapshotEvents.listen((event) {});
    var storageRef = await uploadTask;
    return await storageRef.ref.getDownloadURL();
  }
}
