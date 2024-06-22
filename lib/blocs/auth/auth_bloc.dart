import 'dart:async';

import 'package:mypfeapp/models/data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:image_picker/image_picker.dart';

import '../../repositories/services/storage_service.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  StreamSubscription<auth.User?>? _authUserSubscription;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required StorageRepository storageRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    //on<UpdateUserImages>(_onUpdateUserImages);

    _authUserSubscription = _authRepository.user.listen((authUser) {
      print('Auth user: $authUser');
      if (authUser != null) {
        _userRepository.getUser(authUser.uid).listen((user) {
          add(AuthUserChanged(authUser: authUser, user: user));
        });
      } else {
        add(AuthUserChanged(authUser: authUser));
      }
    });
  }

  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    event.authUser != null
        ? emit(AuthState.authenticated(
            authUser: event.authUser!, user: event.user!))
        : emit(const AuthState.unauthenticated());
  }

  // void _onUpdateUserImages(
  //   UpdateUserImages event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   print(state.status);
  //   if (state is AuthUserChanged) {
  //     print('hi');
  //     User? user = (state as AuthUserChanged).user;
  //     await _storageRepository.uploadImage(user!, event.image);

  //     _userRepository.getUser(user.id!).listen((user) {
  //       add(UpdateUser(user: user));
  //     });
  //   }
  //   print("no");
  // }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }
}
