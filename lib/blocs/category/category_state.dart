// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

///***********************category products****************

class CategoryProductLoadedState extends CategoryState {
  List<Actualite> acts;
  CategoryProductLoadedState({this.acts = const <Actualite>[]});
  @override
  List<Object> get props => [acts];
}

class CategoryProductLoadingState extends CategoryState {}
