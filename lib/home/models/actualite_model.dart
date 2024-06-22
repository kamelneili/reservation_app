import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mypfeapp/models/rating.dart';
part 'actualite_model.g.dart';

@HiveType(typeId: 0)
class Actualite extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String? price;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String nbprs;
  @HiveField(7)
  final bool? dispo;
  @HiveField(8)
  final bool? isRecommended;

  const Actualite(
      {this.id,
      required this.category,
      this.price,
      required this.image,
      required this.description,
      required this.name,
      required this.nbprs,
      this.dispo,
      this.isRecommended});
  @override
  List<Object?> get props => [
        id,
        price,
        description,
        isRecommended,
        image,
        dispo,
        nbprs,
        category,
        name
      ];

  factory Actualite.fromSnapshot(DocumentSnapshot snap) {
    Actualite actualite = Actualite(
      id: snap.id,
      description: snap['description'],
      image: snap['image'],
      name: snap['name'],
      category: snap['category'],
      price: snap['price'],
      dispo: snap['disponibilite'],
      nbprs: snap['nbrperson'],
    );
    return actualite;
  }
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,

      'description': description,
      'image': image,
      'disponibilite': dispo,
      'price': price,
      'nbrperson': nbprs,
      'category': category
    };
  }
}
