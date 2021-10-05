import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static Future<void> delMovie(String title) async {
    await FirebaseFirestore.instance.collection('movies').doc(title).delete();
    await FirebaseStorage.instance
        .ref()
        .child('movieImages')
        .child('$title.jpg')
        .delete();
  }

  static Future<void> statusUpdate(bool status, String title) async {
    await FirebaseFirestore.instance.collection('movies').doc(title).update({
      'status': status,
    });
  }
}
