import 'package:equatable/equatable.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

class Wishlist extends Equatable {
  final List<Actualite> actualites;

  const Wishlist({this.actualites = const <Actualite>[]});

  @override
  List<Object?> get props => [actualites];
}
