import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_event.dart';
import 'package:mypfeapp/home/blocs/actualite_state.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/home/repositories/actualite_repository.dart';

class ActualiteBloc extends Bloc<ActualiteEvent, ActualiteState> {
  final ActualiteRepository _actualiteRepository;
  StreamSubscription? _actualiteSubscription;

  ActualiteBloc({
    required ActualiteRepository actualiteRepository,
  })  : _actualiteRepository = actualiteRepository,
        super(ActualiteLoading()) {
    on<LoadActualite>(_onLoadActualite);
    on<UpdateActualites>(_onUpdateActualites);
    on<AddActualite>(_onAddActualite);
    on<DeleteActualite>(_onDeleteActualite);
  }
  Future<void> _onAddActualite(
    AddActualite event,
    Emitter<ActualiteState> emit,
  ) async {
    // emit(AppointmentLoading());

    //Appointment appointment = new Appointment();
    try {
      await _actualiteRepository.addActualite(event.actualite);

      print('added:');

      emit(ActualiteAdded());
    } catch (_) {}
  }

  //delete act
  Future<void> _onDeleteActualite(
    DeleteActualite event,
    Emitter<ActualiteState> emit,
  ) async {
    try {
      await _actualiteRepository.deleteUser(event.actualite);

      print('added:');

      final List<Actualite> actualites =
          await _actualiteRepository.getAllActualites().first;

      print('srv:');
      print(actualites);

      emit(ActualiteLoaded(actualites: actualites));
    } catch (_) {}
  }

  //
  void _onUpdateActualites(
    UpdateActualites event,
    Emitter<ActualiteState> emit,
  ) {
    print('here i am');
    print(event.actualites);
    emit(ActualiteLoaded(actualites: event.actualites));
  }

  Future<void> _onLoadActualite(
    LoadActualite event,
    Emitter<ActualiteState> emit,
  ) async {
    _actualiteSubscription?.cancel();

    _actualiteSubscription = _actualiteRepository.getAllActualites().listen(
          (products) => add(
            UpdateActualites(products),
          ),
        );

    print('les serveurs sont ');
  }
  //
}
