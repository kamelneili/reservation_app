import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

class ActualiteRepository {
  final FirebaseFirestore _firebaseFirestore;

  ActualiteRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  Future<void> addActualite(Actualite actualite) {
    return _firebaseFirestore.collection('actualites').add(actualite.toMap());
  }

  //Delete user
  Future<void> deleteUser(
    Actualite actualite,
  ) {
    return _firebaseFirestore
        .collection('actualites')
        .doc(actualite.id)
        .delete()
        .then(
          (value) => print('actualite document deleted.'),
        );
  }

  Stream<List<Actualite>> getAllActualites() {
    print('reposrooms');
    return _firebaseFirestore
        .collection('actualites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Actualite.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Actualite>> fetchCategoryProducts(String cat) {
    print('reposrooms');
    return _firebaseFirestore
        .collection('actualites')
        .where('category', isEqualTo: cat)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Actualite.fromSnapshot(doc)).toList();
    });
  }

  Future rateProduct(
    Actualite actualite,
    double rating,
  ) {
    return _firebaseFirestore
        .collection('actualites')
        .doc(actualite.id)
        .update({'rating': rating}).then(
      (value) => print('actualite document rated.'),
    );
  }
  //
}
