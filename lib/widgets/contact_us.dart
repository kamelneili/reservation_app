import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mypfeapp/blocs/appointment/appointment_bloc.dart';
import 'package:mypfeapp/config/constants.dart';

import '../../blocs/appointment/appointment_event.dart';
import '../../blocs/appointment/appointment_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../repositories/appointment/appointment_repository.dart';
import '../../widgets/custom_buttom.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});
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
        child: const ContactInformation(),
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
          title: Text('Contactez-nous ',
              style: kEncodeSansBold.copyWith(color: kBlackColor)),
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
                    padding: const EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                3, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: Card(
                        child: ListTile(
                      title: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text:
                                      ' You can contact us via our online Facebbok/website or call us on the number below: ',
                                  style: kEncodeSansBold.copyWith(
                                      color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text:
                                          ' https://www.facebook.com/groups/1888156904820564/: 00216 20235876. ',
                                      style: kEncodeSansBold.copyWith(
                                          color: Colors.black),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    title: 'accueil',
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
