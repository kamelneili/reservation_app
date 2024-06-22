import 'package:equatable/equatable.dart';

import '../../models/appointment_model.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoaded extends AppointmentState {
  final List<Appointment> appointments;

  AppointmentLoaded({required this.appointments});
  @override
  List<Object> get props => [appointments];
}

class CurrentAppointmentLoaded extends AppointmentState {
  final Appointment appointment;

  CurrentAppointmentLoaded({required this.appointment});
  @override
  List<Object> get props => [appointment];
}
