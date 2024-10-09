class HashGenerator {
  static String idHashing({required String myUid, required String friendUid}) {
    return myUid + friendUid;
  }
}
