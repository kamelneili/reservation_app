import 'dart:ffi';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mypfeapp/blocs/rating/rating_bloc.dart';
import 'package:mypfeapp/blocs/rating/rating_event.dart';
import 'package:mypfeapp/blocs/wishlist/wishlist_bloc.dart';
import 'package:mypfeapp/config/constants.dart';
import 'package:mypfeapp/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/screens/product_details/stars.dart';

import '../../models/product_model.dart';
import '../../widgets/custom_buttom.dart';
import '../../widgets/product_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final Actualite product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    // getrating();
  }

  // getrating() async {
  //   double totalRating = 0;
  //   final currentuser = auth.FirebaseAuth.instance.currentUser;
  //   print("currentuser");
  //   print(currentuser);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double r = prefs.getDouble("r")!;
  //   print("r:$r");
  //  // for (int i = 0; i < widget.product.rating!.length; i++) {
  //     setState(() {
  //       totalRating += r;
  //     });
  //     if (currentuser != null) {
  //      // if (widget.product.rating![i].userId == currentuser.uid) {
  //         myRating = r.toDouble();
  //       }
  //     }
  //   }
  //   if (totalRating != 0) {
  //     setState(() {
  //       avgRating = totalRating / r;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //  Restaurant restaurant = Restaurant.restaurants[0];
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical! * 4,
                              width: SizeConfig.blockSizeVertical! * 4,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhiteColor,
                              ),
                              child: SvgPicture.asset(
                                  'assets/left-navigation-back-svgrepo-com.svg'),
                            ),
                            Container(
                                height: SizeConfig.blockSizeVertical! * 4,
                                width: SizeConfig.blockSizeVertical! * 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kWhiteColor,
                                ),
                                child: const Text("kkkkkkk",
                                    style: TextStyle(
                                        color: Colors
                                            .red)) //SvgPicture.asset('favourite-svgrepo-com.svg'),
                                )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical! * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 50),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.product.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
//rating

                //
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Evaluation',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    print('here');
                    context.read<RatingBloc>().add(RateProductEvent(
                          product: widget.product,
                          rate: rating,
                        ));
                  },
                ),

                //
                ProductInformation(product: widget.product),
                CustomButton(
                  title: "réservation",
                  onTap: () async {
                    final user = auth.FirebaseAuth.instance.currentUser;
                    print(user);
                    // user != null
                    //     ?
                    Navigator.pushNamed(context, '/delivery_time',
                        arguments: widget.product);
                    // :
                    // Navigator.pushNamed(context, '/loginScreen');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
