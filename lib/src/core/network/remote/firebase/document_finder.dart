import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_handler.dart';
import 'firestore_collection_name.dart';

class DocumentFinder {
  static Future<bool> checkExistence({required String roomID}) async {
    QuerySnapshot<Map<String, dynamic>> ref = await FirebaseHandler.fireStore
        .collection(FirestoreCollectionName.chatCollection)
        .get();

    for (var doc in ref.docs) {
      if (doc.id == roomID) return true;
    }
    return false;
  }
}
