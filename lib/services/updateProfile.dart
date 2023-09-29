import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/usermodel.dart';

class UpdateProfileServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String mediaUrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> updateProfile(UserModel userModel) async {
    try {
      await _firestore
          .collection("User")
          .doc(_auth.currentUser!.uid)
          .set(userModel.toMap(), SetOptions(merge: true));
      Fluttertoast.showToast(msg: "Güncelleme başarılı");
    } catch (e) {
      Fluttertoast.showToast(msg: "Güncelleme başarısız");
    }
  }
}
