import 'package:mypfeapp/models/appointment_model.dart';

abstract class BaseAppointmentRepository {
  Future<void> addAppointment(Appointment appointment);
}
