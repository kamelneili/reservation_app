import 'package:mypfeapp/blocs/auth/auth_bloc.dart';
import 'package:mypfeapp/blocs/profile/profile_bloc.dart';
import 'package:mypfeapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/repositories.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Body({super.key});
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
          userRepository: context.read<UserRepository>(),
        )..add(
            LoadProfile(context.read<AuthBloc>().state.authUser),
          ),
        child: Body(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          //  ProfilePic(),

          const SizedBox(height: 20),
          ProfileMenu(
            text: LocaleKeys.myprofil.tr(),
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.pushNamed(context, '/profile')},
          ), //

          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            if (state is ProfileLoaded) {
              print(state.user.genre);
              if (state.user.genre == 'propriétaire') {
                return ProfileMenu(
                  text: LocaleKeys.notif.tr(),
                  icon: "assets/icons/Bell.svg",
                  press: () => {Navigator.pushNamed(context, '/newact')},
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const Text('something went wrong');
            }
          }),

          ProfileMenu(
            text: LocaleKeys.settings.tr(),
            icon: "assets/icons/Settings.svg",
            press: () => {Navigator.pushNamed(context, '/basket')},
          ),
          ProfileMenu(
            text: LocaleKeys.help.tr(),
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: LocaleKeys.logout.tr(),
            icon: "assets/icons/Log out.svg",
            press: () async {
              context.read<AuthRepository>().signOut();
              Navigator.pushNamed(context, '/home');

//                   BlocProvider.of<UserBloc>(context).add(LogoutEvent());

//  //SharedPreferences pref = await SharedPreferences.getInstance();
//  int userId = pref.getInt('id');
//         String token = pref.getString("token");
//        print(token);
//                   if(state is LogoutState){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return SignInScreen();
//                   }));
//                   }
            },
          ),
        ],
      ),
    );
  }
}
