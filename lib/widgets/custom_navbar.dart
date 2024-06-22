import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../repositories/auth/auth_repository.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int current = 0;

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: BottomAppBar(
          // color: Colors.black,
          //  fixedColor: Colors.red,

          elevation: 0,
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(shape: BoxShape.circle),
              height: 70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: _currentIndex == 0
                        ? SvgPicture.asset(
                            height: 40, 'assets/svg/home_selected.svg')
                        : SvgPicture.asset(
                            height: 40, 'assets/svg/home_unselected.svg'),
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/SignupScreen');
                  //     },
                  //     icon: Icon(Icons.phone, color: Colors.grey)),
                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/account');
                  //     },
                  //     icon: Icon(Icons.shopping_basket, color: Colors.grey)),
                  IconButton(
                    onPressed: () async {
                      final user = await auth.FirebaseAuth.instance.currentUser;
                      print(user);
                      user != null
                          ? Navigator.pushNamed(
                              context,
                              '/account',
                            )
                          : Navigator.pushNamed(context, '/loginScreen');
                    },
                    icon: _currentIndex == 1
                        ? SvgPicture.asset(
                            height: 40, 'assets/svg/person_selected.svg')
                        : SvgPicture.asset(
                            height: 40, 'assets/svg/person_selected.svg'),
                  ),
                  IconButton(
                    onPressed: () {
                      //  context.read<AuthBloc>().add(SignOutRequested());
                      // RepositoryProvider.of<AuthRepository>(context).signOut();
                      Navigator.pushNamed(context, '/contactInformation');
                    },
                    icon: _currentIndex == 0
                        ? SvgPicture.asset(
                            height: 40, 'assets/svg/phone_selected.svg')
                        : SvgPicture.asset(
                            height: 40, 'assets/svg/phone_unselected.svg'),
                  )
                ],
              ))),
    );
  }
}
//icon: const Icon(Icons.logout)
 
                    //**** */
                   