import 'package:mypfeapp/blocs/appointment/appointment_bloc.dart';
import 'package:mypfeapp/blocs/basket/basket_bloc.dart';
import 'package:mypfeapp/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../blocs/appointment/appointment_event.dart';
import '../../blocs/appointment/appointment_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../repositories/appointment/appointment_repository.dart';
import '../../widgets/custom_buttom.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<AppointmentBloc>(
        create: (context) => AppointmentBloc(
          appointmentRepository: context.read<AppointmentRepository>(),
        )..add(
            LoadAppointments(context.read<AuthBloc>().state.authUser),
          ),
        child: const BasketScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
//Theme.of(context).backgroundColor,
        appBar: AppBar(
          //backgroundColor: Theme.of(context).primaryColor,
          //elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Mes réservations',
              style: kEncodeSansBold.copyWith(color: kBlackColor)),

          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/delivery_time');
                },
                icon: const Icon(Icons.edit, color: Colors.white))
          ],
        ),

        //*
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 500.h,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(3, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: BlocBuilder<AppointmentBloc, AppointmentState>(
                    builder: (context, state) {
                      if (state is AppointmentLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AppointmentLoaded) {
                        print('state is AppointmentLoaded');
                        return SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: state.appointments.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            state.appointments[index]
                                                        .isAccepted ==
                                                    true
                                                ? Text("Accepté",
                                                    style: kEncodeSansBold
                                                        .copyWith(
                                                            color:
                                                                Colors.green))
                                                : Text("En attente",
                                                    style: kEncodeSansBold
                                                        .copyWith(
                                                            color: Colors.red)),
                                            Text(' Réservation :',
                                                style: kEncodeSansBold.copyWith(
                                                    color: Colors.black)),
                                            Row(
                                              children: [
                                                Text(
                                                    '${DateFormat('yyyy-MM-dd').format(state.appointments[index].createdAt)} ',
                                                    style: kEncodeSansBold
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                                Text(
                                                    state.appointments[index]
                                                        .time,
                                                    style: kEncodeSansBold
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                              ],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<AppointmentBloc>()
                                                      .add(DeleteAppointment(
                                                          state.appointments[
                                                              index]));
                                                  const snackBar = SnackBar(
                                                      content: Text(
                                                          'Réservation bien supprimé!!!',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);

                                                  Navigator.pushNamed(
                                                      context, '/home');
                                                },
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "supprimer",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                AppointmentBloc>()
                                                            .add(DeleteAppointment(
                                                                state.appointments[
                                                                    index]));
                                                        const snackBar = SnackBar(
                                                            content: Text(
                                                                'Rendez-vous bien supprimé!!!',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red)));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);

                                                        Navigator.pushNamed(
                                                            context, '/home');
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      } else
                        return const Text('something went wrong');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    title: 'Accueil',
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
