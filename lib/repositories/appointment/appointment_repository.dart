import 'package:mypfeapp/models/appointment_model.dart';
import 'package:mypfeapp/repositories/appointment/base_appointment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentRepository extends BaseAppointmentRepository {
  final FirebaseFirestore _firebaseFirestore;

  AppointmentRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addAppointment(Appointment appointment) {
    print('addappointments');

    return _firebaseFirestore
        .collection('appointment')
        .add(appointment.toDocument());
  }

  Stream<List<Appointment>> getAppointments(userId) {
    print('getappointments');
    return _firebaseFirestore
        .collection('appointment')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Appointment.fromSnapshot(doc)).toList();
    });
  }

//Delete appointmnt
  Future<void> deleteAppointment(
    Appointment appointment,
  ) {
    return _firebaseFirestore
        .collection('appointment')
        .doc(appointment.id)
        .delete()
        .then(
          (value) => print('appointment document deleted.'),
        );
  }

  //
}
