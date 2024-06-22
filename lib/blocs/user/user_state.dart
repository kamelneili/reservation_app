import 'package:mypfeapp/models/data_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  const UserLoaded({this.users = const <User>[]});
  @override
  List<Object> get props => [users];
}
