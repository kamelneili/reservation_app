import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/data_model.dart';
import '../../models/models.dart';
import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    bool userExist =
        (await _firebaseFirestore.collection('users').doc(user.id).get())
            .exists;

    if (userExist) {
      return;
    } else {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toDocument());
    }
  }

  @override
  Stream<User> getUser(String userId) {
    print('Getting user data from Cloud Firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) {
      return User.fromSnapshot(snap);
    });
  }
//get all doctors

  @override
  Stream<List<User>> getDoctors() {
    print('Getting all doctors data from Cloud Firestore');
    return _firebaseFirestore
        .collection('users')
        .where('genre', isEqualTo: "doctor")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument())
        .then(
          (value) => print('User document updated.'),
        );
  }
}
