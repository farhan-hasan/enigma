import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHandler {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static FirebaseAuth get auth {
    return _auth;
  }

  static FirebaseFirestore get fireStore {
    return _firestore;
  }

  static FirebaseStorage get storage {
    return _storage;
  }
}
