// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class RatingState extends Equatable {
  @override
  List<Object> get props => [];
}

///*********** rate */
class ProductRatedState extends RatingState {
  ProductRatedState();
  @override
  List<Object> get props => [];
}

class ProductRatingState extends RatingState {}
