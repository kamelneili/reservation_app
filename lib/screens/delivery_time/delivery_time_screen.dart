import 'dart:convert';

import 'package:mypfeapp/blocs/appointment/appointment_event.dart';
import 'package:mypfeapp/blocs/profile/profile_bloc.dart';
import 'package:mypfeapp/blocs/user/user_bloc.dart';
import 'package:mypfeapp/blocs/user/user_state.dart';
import 'package:mypfeapp/config/size_config.dart';
import 'package:mypfeapp/config/theme.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/models/delivery_time_model.dart';
import 'package:mypfeapp/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/appointment/appointment_bloc.dart';
import '../../blocs/appointment/appointment_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/basket/basket_bloc.dart';
import '../../config/constants.dart';
import '../../models/appointment_model.dart';
import '../../repositories/appointment/appointment_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mypfeapp/local_push_notification.dart';

class DeliveryTimeScreen extends StatefulWidget {
  const DeliveryTimeScreen({super.key, this.title, required this.product});
  final String? title;
  final Actualite product;
  static const String routeName = '/delivery_time';
  // final user = auth.FirebaseAuth.instance.currentUser!;

  static Route route({required Actualite product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),

      //
      builder: (context) => BlocProvider<AppointmentBloc>(
        create: (context) => AppointmentBloc(
          appointmentRepository: context.read<AppointmentRepository>(),
        )..add(LoadAppointments(context.read<AuthBloc>().state.authUser)),
        child: DeliveryTimeScreen(product: product),
      ),
      //
    );
  }

  @override
  _DeliveryTimeScreenState createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {
  //
  final DatePickerController _controller = DatePickerController();

  //FocusScope.of(context).requestFocus(new FocusNode());
  DateTime _selectedValue = DateTime.now();
  late DeliveryTime time;
  //bool selected = false;
  DateTime? inactive;
  List<DateTime> d = [];
  @override
  void initState() {
    super.initState();

    DateTime inactive = DateTime.now().add(const Duration(days: 20));
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    storeNotificationToken();
  }

  //notif
  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=dEHnOghpQLi303MbQUGc7z:APA91bEODrhRCiAlPlsIkFo7mE-186CfHzod5O26RDlFwCbMS3eRN29e96u1bp_YczpZ4LEwAd_1Hxg95uGyjLNTlkP0VUHS5PxU1TUNvtGUB4y0yKjmAvAzSPj_IUXleVHLfDHT3AuV'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': 'You are followed by someone'
                },
                'priority': 'high',
                'data': data,
                'to': token
              }));

      if (response.statusCode == 200) {
        print("Yeh notification is sended");
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  //

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: Text(
            'Date de réservation',
            style: kEncodeSansBold.copyWith(color: kBlackColor),
          ),
        ),
        extendBodyBehindAppBar: true,
        //                    Navigator.pushNamed(context, '/basket');

        bottomNavigationBar: BottomAppBar(
          // color: Colors.black,
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                )))),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setInt('notif', 1);
                      final currentuser =
                          auth.FirebaseAuth.instance.currentUser;
                      print("currentuser");
                      print(currentuser);
                      if (currentuser != null) {
                        {
                          DocumentSnapshot snap = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(currentuser.uid)
                              .get();
                          String? token = snap['token'];
                          sendNotification('réservation ajoutée', token!);

                          context.read<AppointmentBloc>().add(AddAppointment(
                              appointment: Appointment(
                                  isAccepted: false,
                                  isCancelled: false,
                                  isDelivered: false,
                                  total: 0,
                                  productId: widget.product.id.toString(),
                                  userId: currentuser.uid,
                                  createdAt: _selectedValue,
                                  time: time.value.toString())));
                          context
                              .read<AppointmentBloc>()
                              .add(LoadAppointments(currentuser));

                          //
                          //
                          const snackBar = SnackBar(
                              content: Text('réservation bien ajouté !!!',
                                  style: TextStyle(color: Colors.green)));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.pushNamed(context, '/basket');
                        }
                      } else {
                        print('here');
                        Navigator.pushNamed(context, '/loginScreen');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("réserver"),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: double.infinity,
                    height: 300.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 130.0, bottom: 20),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Choisissez une date',
                              style:
                                  Theme.of(context).textTheme.headlineSmall!),

                          //datepicker
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                BlocBuilder<AppointmentBloc, AppointmentState>(
                                    builder: (context, state) {
                              if (state is AppointmentLoaded) {
                                print(AppointmentLoaded);

                                List<Appointment> appointments =
                                    state.appointments;
                                for (var i = 0; i < appointments.length; i++) {
                                  d.add(appointments[i].createdAt);
                                }
                                print([...d]);

                                return DatePicker(
                                  DateTime.now(),
                                  initialSelectedDate: DateTime.now(),
                                  selectionColor: Colors.pink,
                                  selectedTextColor: Colors.white,
                                  inactiveDates: d,
                                  controller: _controller,
                                  deactivatedColor: Colors.blue,
                                  onDateChange: (date) {
                                    // New date selected

                                    setState(() {
                                      _selectedValue = date;
                                      //   inactiveDates inactive = date;
                                      print(inactive);
                                    });
                                  },
                                );
                              } else {
                                return DatePicker(
                                  height: 90.sp,
                                  DateTime.now(),
                                  initialSelectedDate: DateTime.now(),
                                  selectionColor: Colors.pink,
                                  selectedTextColor: Colors.white,
                                  // inactiveDates: [DateTime.now()],
                                  controller: _controller,
                                  deactivatedColor: Colors.blue,
                                  onDateChange: (date) {
                                    // New date selected

                                    setState(() {
                                      _selectedValue = date;
                                      //   inactiveDates inactive = date;
                                      print(inactive);
                                    });
                                  },
                                );
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              //
              //

//************************************* */

              const SizedBox(
                height: 30,
              ),
              //
              Center(
                child: Text('Horaires disponibles',
                    style: Theme.of(context).textTheme.headlineSmall!),
              ),
              /*************** */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MasonryGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 23,
                      itemCount: DeliveryTime.deliveryTimes.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingHorizontal),
                      itemBuilder: (context, index) {
                        return BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            return Card(
                                child: TextButton(
                                    onPressed: () {
                                      time = DeliveryTime.deliveryTimes[index];

                                      context.read<BasketBloc>().add(
                                          SelectDeliveryTime(
                                              DeliveryTime.deliveryTimes[index],
                                              _selectedValue));
                                      // selected = true;
                                    },
                                    child: Text(
                                        DeliveryTime.deliveryTimes[index].value,
                                        style: const TextStyle(
                                            color: Colors.red))));
                          },
                        );
                      }),
                ],
              )

              /******************* */
            ],
          ),
        ));
  }
}
