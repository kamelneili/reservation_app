// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:equatable/equatable.dart';

abstract class SearchEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductEvent extends SearchEvents {}

class LoadingProductEvent extends SearchEvents {
  @override
  List<Object> get props => [];
}

class DisplayRateProductEvent extends SearchEvents {}

class SearchProductEvent extends SearchEvents {
  String query;
  SearchProductEvent({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}
