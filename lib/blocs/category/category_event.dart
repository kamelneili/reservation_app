// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class CategoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCategoryProductEvent extends CategoryEvents {
  String category;
  LoadCategoryProductEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class LoadingCategoryProductEvent extends CategoryEvents {}
