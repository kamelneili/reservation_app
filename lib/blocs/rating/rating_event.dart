// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

abstract class RatingEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class RateProductEvent extends RatingEvents {
  double rate;
  Actualite product;
  RateProductEvent({
    required this.rate,
    required this.product,
  });
  @override
  List<Object> get props => [product, rate];
}
