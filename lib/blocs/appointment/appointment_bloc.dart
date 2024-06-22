import 'dart:async';

import 'package:mypfeapp/repositories/appointment/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mypfeapp/blocs/appointment/appointment_event.dart';
import 'package:mypfeapp/blocs/appointment/appointment_state.dart';
import 'package:mypfeapp/models/appointment_model.dart';
import 'package:mypfeapp/models/delivery_time_model.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  StreamSubscription? _appointmentSubscription;
  final AppointmentRepository _appointmentRepository;
  AppointmentBloc({
    required AppointmentRepository appointmentRepository,
  })  : _appointmentRepository = appointmentRepository,
        super(AppointmentLoading()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<UpdateAppointments>(_onUpdateAppointments);
    on<DeleteAppointment>(_onDeleteAppointment);

    on<AddAppointment>(_onAddAppointment);
  }
  //
  void _onDeleteAppointment(event, Emitter<AppointmentState> emit) async {
    print("delete");
    await _appointmentRepository.deleteAppointment(event.appointment);
  }

  Future<void> _onLoadAppointments(
    LoadAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    final state = this.state;
    // emit(AppointmentLoading());

    //Appointment appointment = new Appointment();
    try {
      _appointmentSubscription?.cancel();
      _appointmentSubscription =
          _appointmentRepository.getAppointments(event.authUser!.uid).listen(
                (appointments) => add(
                  UpdateAppointments(appointments),
                ),
              );
      print('mmm');
      final aps = await _getaps(event.authUser!.uid);
      print('aps:');
      print(aps);

      emit(AppointmentLoaded(appointments: aps));
    } catch (_) {}
  }
  //

  Future<List<Appointment>> _getaps(String userId) async {
    List<Appointment> apps;
    print(userId);
    apps = await _appointmentRepository.getAppointments(userId).first;

    print(apps);

    return apps.toList();
  }

  //

  void _onUpdateAppointments(
    UpdateAppointments event,
    Emitter<AppointmentState> emit,
  ) {
    print('kkkamel');
    print(event.appointments);

    emit(AppointmentLoaded(appointments: event.appointments));
    print('kamellll');
  }

  //

  Future<void> _onAddAppointment(
    AddAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    final state = this.state;
    //Appointment appointment = new Appointment();
    try {
      await _appointmentRepository.addAppointment(event.appointment);
      // emit(AppointmentLoading());
    } catch (_) {}
  }
}
 
  /*

  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is StartBasket) {
      yield* _mapStartBasketToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event, state);
    } else if (event is RemoveItem) {
      yield* _mapRemoveItemToState(event, state);
    } else if (event is RemoveAllItem) {
      yield* _mapRemoveAllItemToState(event, state);
    } else if (event is ToggleSwitch) {
      yield* _mapToggleSwitchToState(event, state);
    } else if (event is AddVoucher) {
      yield* _mapAddVoucherToState(event, state);
    }
  }


  Stream<BasketState> _mapStartBasketToState() async* {
    yield BasketLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield BasketLoaded(basket: Basket());
    } catch (_) {}
  }

  Stream<BasketState> _mapAddItemToState(
      AddItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
                items: List.from(state.basket.items)..add(event.item)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapRemoveItemToState(
      RemoveItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
                items: List.from(state.basket.items)..remove(event.item)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapRemoveAllItemToState(
      RemoveAllItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
                items: List.from(state.basket.items)
                  ..removeWhere((item) => item == event.item)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapToggleSwitchToState(
    ToggleSwitch event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(cutlery: !state.basket.cutlery));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapAddVoucherToState(
      AddVoucher event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(voucher: event.voucher));
      } catch (_) {}
    }
  }
  
}
*/
