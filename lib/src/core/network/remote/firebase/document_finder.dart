import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';

import 'firebase_handler.dart';
import 'firestore_collection_name.dart';

class DocumentFinder {
  static Future<bool> checkExistence({required String roomID}) async {
    QuerySnapshot<Map<String, dynamic>> ref = await FirebaseHandler.fireStore
        .collection(FirestoreCollectionName.chatCollection)
        .get();
    // debug(roomID);
    // debug(ref.docs.length);
    for (QueryDocumentSnapshot doc in ref.docs) {
      // debug(doc.id);
      // if (doc.id == roomID) return true;
    }
    return false;
  }
}
