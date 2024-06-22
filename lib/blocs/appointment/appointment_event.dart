import 'package:equatable/equatable.dart';

import 'package:mypfeapp/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/delivery_time_model.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class DeleteAppointment extends AppointmentEvent {
  final Appointment appointment;
  const DeleteAppointment(this.appointment);
  @override
  List<Object> get props => [appointment];
}

class StartAppointment extends AppointmentEvent {
  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  final auth.User? authUser;

  const LoadAppointments(this.authUser);
  // @override
  // List<Object?> get props => [authUser];
}

class UpdateAppointments extends AppointmentEvent {
  final List<Appointment> appointments;
  const UpdateAppointments(this.appointments);
  @override
  List<Object> get props => [appointments];
}

class AddAppointment extends AppointmentEvent {
  //final DeliveryTime deliveryTime;
  //final DateTime _selectedValue;
  final Appointment appointment;
  // final int? id;
  // final int patientId;
  // //final List<int> productIds;
  // //final double deliveryFee;
  // //final double subtotal;
  // final double total;
  // final int doctorId;
  // final bool isAccepted;
  // final bool isDelivered;
  // final bool isCancelled;

  // final DateTime createdAt;
  const AddAppointment({
    required this.appointment,
  });
  @override
  List<Object> get props => [
        // patientId,
        // total,
        // doctorId,
        // isAccepted,
        // isDelivered,
        // isCancelled,
        // createdAt
        appointment
      ];
}
