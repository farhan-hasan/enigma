import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_order_by_model.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHandler {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseMessaging _message = FirebaseMessaging.instance;

  static FirebaseAuth get auth {
    return _auth;
  }

  static FirebaseFirestore get fireStore {
    return _firestore;
  }

  static FirebaseStorage get storage {
    return _storage;
  }

  static FirebaseMessaging get fcm {
    return _message;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> get(
      {required String collectionName,
      FirebaseWhereModel? where,
      FirebaseOrderByModel? orderBy}) async {
    Object ref = _firestore.collection(collectionName);
    orderBy = null;
    if (where != null) {
      // debug(where.whereIn);
      // debug(where.whereNotIn);
      if (where.whereIn == null) {
        //debug("found whereNotIn");
        ref = (ref as CollectionReference).where(
          where.field ?? "",
          whereNotIn: where.whereNotIn,
          arrayContains: where.arrayContains,
          arrayContainsAny: where.arrayContainsAny,
          isEqualTo: where.isEqualTo,
          isGreaterThan: where.isGreaterThan,
          isGreaterThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isLessThan: where.isLessThan,
          isLessThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isNotEqualTo: where.isNotEqualTo,
          isNull: where.isNull,
        );
      } else if (where.whereNotIn == null) {
        // debug("found whereIn");
        ref = (ref as CollectionReference).where(
          where.field ?? "",
          whereIn: where.whereIn,
          arrayContains: where.arrayContains,
          arrayContainsAny: where.arrayContainsAny,
          isEqualTo: where.isEqualTo,
          isGreaterThan: where.isGreaterThan,
          isGreaterThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isLessThan: where.isLessThan,
          isLessThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isNotEqualTo: where.isNotEqualTo,
          isNull: where.isNull,
        );
      } else if (where.whereNotIn == null && where.whereIn == null) {
        // debug("whereIn and whereNotIn cannot be used together");
        ref = (ref as CollectionReference).where(
          where.field ?? "",
          arrayContains: where.arrayContains,
          arrayContainsAny: where.arrayContainsAny,
          isEqualTo: where.isEqualTo,
          isGreaterThan: where.isGreaterThan,
          isGreaterThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isLessThan: where.isLessThan,
          isLessThanOrEqualTo: where.isGreaterThanOrEqualTo,
          isNotEqualTo: where.isNotEqualTo,
          isNull: where.isNull,
        );
      } else {
        // debug("whereIn and whereNotIn cannot be used together");
        throw FirebaseException(
            plugin: "whereIn and whereNotIn cannot be used together");
      }
    }
    if (orderBy != null) {
      ref =
          (ref as Query).orderBy(orderBy.field, descending: orderBy.descending);
    }
    return await (ref as Query<Map<String, dynamic>>).get();
  }
}
