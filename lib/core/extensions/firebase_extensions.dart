import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/domain/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirestoreDocumentExtensions on DocumentReference {
  Future<DocumentSnapshot> getCacheFirst() async {
    try {
      final ds = await get(const GetOptions(source: Source.cache));
      if (ds.data() == null) {
        return get(const GetOptions(source: Source.server));
      }
      return ds;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}

extension FirestoreQueryExtensions on Query {
  Future<QuerySnapshot> getCacheFirst() async {
    try {
      final qs = await get(const GetOptions(source: Source.cache));
      if (qs.docs.isEmpty) {
        return get(const GetOptions(source: Source.server));
      }
      return qs;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}

extension FirebaseUserExtensions on User {
  AppUser toAppUser() {
    return AppUser(
      uid: uid,
      email: email ?? '',
      name: displayName ?? email ?? '',
      photoUrl: photoURL,
    );
  }
}
