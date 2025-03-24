import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/models/share.dart';
import 'package:dossier_locataire/shared/models/user.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

class Storage {
  static CollectionReference<Occupant> get occupants {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("occupants")
        .withConverter(
          fromFirestore: (snapshot, _) => Occupant.fromFirestore(snapshot),
          toFirestore: (occupant, _) => Occupant.toFirestore(occupant),
        );
  }

  static DocumentReference<Occupant> occupant(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("occupants")
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, _) => Occupant.fromFirestore(snapshot),
          toFirestore: (occupant, _) => Occupant.toFirestore(occupant),
        );
  }

  static CollectionReference<Warrantor> get warrantors {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("warrantors")
        .withConverter(
          fromFirestore: (snapshot, _) => Warrantor.fromFirestore(snapshot),
          toFirestore: (warrantor, _) => Warrantor.toFirestore(warrantor),
        );
  }

  static DocumentReference<Warrantor> warrantor(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("warrantors")
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, _) => Warrantor.fromFirestore(snapshot),
          toFirestore: (warrantor, _) => Warrantor.toFirestore(warrantor),
        );
  }

  static CollectionReference<Share> get shares {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("shares")
        .withConverter(
          fromFirestore: (snapshot, _) => Share.fromFirestore(snapshot.data()),
          toFirestore: (share, _) => Share.toFirestore(share),
        );
  }

  static DocumentReference<Share> share(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("shares")
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, _) => Share.fromFirestore(snapshot.data()),
          toFirestore: (share, _) => Share.toFirestore(share),
        );
  }

  static CollectionReference<User> get users {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter(
          fromFirestore: (snapshot, _) => User.fromFirestore(snapshot.data()),
          toFirestore: (user, _) => User.toFirestore(user),
        );
  }

  static DocumentReference<User> user(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, _) => User.fromFirestore(snapshot.data()),
          toFirestore: (user, _) => User.toFirestore(user),
        );
  }
}
