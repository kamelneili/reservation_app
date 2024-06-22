import 'dart:async';

import 'package:mypfeapp/blocs/user/user_event.dart';
import 'package:mypfeapp/blocs/user/user_state.dart';
import 'package:mypfeapp/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateUsers>(_onUpdateUsers);
  }

  void _onLoadUsers(event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository
        .getDoctors()
        .listen((doctors) => add(UpdateUsers(doctors)));
  }

  void _onUpdateUsers(event, Emitter<UserState> emit) async {
    emit(UserLoaded(users: event.doctors));
  }
}
