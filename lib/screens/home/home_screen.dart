// import 'dart:convert';

// import 'package:piscine_app/local_push_notification.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:piscine_app/config/constants.dart';
// import 'package:piscine_app/config/size_config.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../blocs/product/product_bloc.dart';
// import '../../widgets/custom_navbar.dart';

// // ignore: must_be_immutable
// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/home';

//   const HomeScreen({super.key});

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (_) => const HomeScreen(),
//     );
//   }

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<String> categories = [
//     "All",
//     "Bridal",
//     "MakeUp",
//     "Massage",
//     "Hair",
//     "FaceSkin"
//   ];

//   List<String> icons = [
//     "All items_icon",
//     "Dress_icon",
//     "Hat_icon",
//     "Watch_icon"
//   ];

//   int current = 0;

//   final int _currentIndex = 0;

//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     // ignore: prefer_const_constructors
//     return Scaffold(
//       //appBar: CustomAppBar(),
//       bottomNavigationBar: const CustomNavBar(),
//       //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       // floatingActionButton: Container(
//       //   padding: EdgeInsets.symmetric(horizontal: 8),
//       //   height: 64,
//       //   child: CustomNavigationBar(
//       //       isFloating: true,
//       //       borderRadius: Radius.circular(40),
//       //       selectedColor: kWhiteColor,
//       //       unSelectedColor: kGreyColor,
//       //       backgroundColor: kBrownColor,
//       //       strokeColor: Colors.transparent,
//       //       scaleFactor: 0.1,
//       //       iconSize: 40,
//       //       items: [
//       //         CustomNavigationBarItem(
//       //           icon: _currentIndex == 0
//       //               ? SvgPicture.asset(
//       //                   height: 40, 'assets/svg/home_selected.svg')
//       //               : SvgPicture.asset(
//       //                   height: 40, 'assets/svg/home_unselected.svg'),
//       //         ),
//       //         CustomNavigationBarItem(
//       //           icon: _currentIndex == 1
//       //               ? SvgPicture.asset(
//       //                   height: 40, 'assets/svg/person_selected.svg')
//       //               : SvgPicture.asset(
//       //                   height: 40, 'assets/svg/person_unselected.svg'),
//       //         ),
//       //         CustomNavigationBarItem(
//       //           icon: _currentIndex == 2
//       //               ? SvgPicture.asset(
//       //                   height: 40, 'assets/svg/phone_selected.svg')
//       //               : SvgPicture.asset(
//       //                   height: 40, 'assets/svg/phone_unselected.svg'),
//       //         ),
//       //       ],
//       //       currentIndex: _currentIndex,
//       //       onTap: (index) {
//       //         setState(() {
//       //           _currentIndex = index;
//       //         });
//       //       }),
//       // ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Center(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 130.h,
//                     width: 160.w,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.7),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset:
//                               const Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                       shape: BoxShape.circle,
//                       image: const DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage("assets/splash.png"),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//               SizedBox(
//                 height: 18.h,
//               ),
//               SizedBox(
//                   height: 38.h,
//                   width: double.infinity,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 4,
//                     itemBuilder: ((context, index) => GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               current = index;
//                             });

//                             context.read<ProductBloc>().add(
//                                 LoadCategoryProducts(
//                                     category: categories[index]));
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 9),
//                             margin: EdgeInsets.only(
//                                 left: index == 0 ? kPaddingHorizontal : 15,
//                                 right: index == categories.length - 1
//                                     ? kPaddingHorizontal
//                                     : 0),
//                             height: 38.h,
//                             decoration: BoxDecoration(
//                               color:
//                                   current == index ? kBrownColor : kGreysColor,
//                               borderRadius: BorderRadius.circular(8),
//                               border: current == index
//                                   ? null
//                                   : Border.all(
//                                       color: kLightGreyColor,
//                                       width: 1,
//                                     ),
//                             ),
//                             child: Text(categories[index],
//                                 style: current == index
//                                     ? kEncodeSansMedium.copyWith(
//                                         color: current == index
//                                             ? kWhiteColor
//                                             : kDarkBrownColor,
//                                         fontSize: 16.sp,
//                                         //SizeConfig.blockSizeHorizontal! * 3,
//                                       )
//                                     : kEncodeSansRagular.copyWith(
//                                         color: current == index
//                                             ? kWhiteColor
//                                             : kDarkBrownColor,
//                                         fontSize: 16.sp,
//                                         //SizeConfig.blockSizeHorizontal! * 3,
//                                       )),
//                           ),
//                         )),
//                   )),
//               const SizedBox(
//                 height: 24,
//               ),

//               //

//               BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
//                 if (state is ProductLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is ProductLoaded) {
//                   return MasonryGridView.count(
//                     physics: const NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 23,
//                     itemCount: state.products.length,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: kPaddingHorizontal),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                             '/ProductDetails',
//                             arguments: state.products[index],
//                           );
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//                                 Positioned(
//                                   child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(kBorderRadius),
//                                       child: Image(
//                                         height: 124,
//                                         width: 161,
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                             state.products[index].imageUrl),
//                                       )),
//                                 ),
//                                 Positioned(
//                                     top: 12,
//                                     right: 12,
//                                     child: GestureDetector(
//                                         // onTap: () {},
//                                         // child: const Image(
//                                         //   height: 20,
//                                         //   width: 20,
//                                         //   image: AssetImage(
//                                         //       'assets/images/unselected_favourite.png'),
//                                         // ),
//                                         ))
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Text(state.products[index].name,
//                                 style: kEncodeSansCondensedThin.copyWith(
//                                   color: kDarkBrownColor,
//                                   fontSize: 16.sp,
//                                 )),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("\$${state.products[index].price}",
//                                     style: kEncodeSansSemiBold.copyWith(
//                                       color: kBlackColor,
//                                       fontSize: 12.sp,
//                                       //SizeConfig.blockSizeHorizontal! * 3.5,
//                                     )),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.start,
//                                         color: kYellowColor, size: 16),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Text("5.0%",
//                                         style: kEncodeSansRagular.copyWith(
//                                           color: kDarkBrownColor,
//                                           fontSize: 12.sp,
//                                           //SizeConfig.blockSizeHorizontal! * 3,
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is CategoryProductLoaded) {
//                   print("filter");
//                   return MasonryGridView.count(
//                     shrinkWrap: true,
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 23,
//                     itemCount: state.products.length,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: kPaddingHorizontal),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                             '/ProductDetails',
//                             arguments: state.products[index],
//                           );
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//                                 Positioned(
//                                   child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(kBorderRadius),
//                                       child: Image(
//                                         height: 124,
//                                         width: 161,
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                             state.products[index].imageUrl),
//                                       )),
//                                 ),
//                                 Positioned(
//                                     top: 12,
//                                     right: 12,
//                                     child: GestureDetector(
//                                         // onTap: () {},
//                                         // child: const Image(
//                                         //   height: 20,
//                                         //   width: 20,
//                                         //   image: AssetImage(
//                                         //       'assets/images/unselected_favourite.png'),
//                                         // ),
//                                         ))
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Text(state.products[index].name,
//                                 style: kEncodeSansCondensedThin.copyWith(
//                                   color: kDarkBrownColor,
//                                   fontSize: 16.sp,
//                                 )),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("\$${state.products[index].price}",
//                                     style: kEncodeSansSemiBold.copyWith(
//                                       color: kBlackColor,
//                                       fontSize: 12.sp,
//                                       //SizeConfig.blockSizeHorizontal! * 3.5,
//                                     )),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.start,
//                                         color: kYellowColor, size: 16),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Text("5.0%",
//                                         style: kEncodeSansRagular.copyWith(
//                                           color: kDarkBrownColor,
//                                           fontSize: 12.sp,
//                                           //SizeConfig.blockSizeHorizontal! * 3,
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 //
//                 else
//                   return const Text("something went wrong");
//               })
//               //

//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Icons.menu, color: Colors.white),
//         onPressed: () {},
//       ),
//       title: Center(
//           child: Container(
//               margin: const EdgeInsets.only(right: 5.0),
//               //width: double.infinity,
//               height: 100.h,
//               width: 100.w,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.7),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(3, 3), // changes position of shadow
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(5.0),
//                 image: const DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/logo.png'),
//                 ),
//               ))),
//       actions: [
//         IconButton(
//             onPressed: () {
//               // Navigator.pushNamed(context, '/wishlist');
//               // Navigator.of(context).pushNamed(
//               //   '/product',
//               //   arguments: product,
//               // );
//             },
//             icon: const Icon(Icons.favorite, color: Colors.white)),
//         Stack(
//           children: [
//             Positioned(
//               top: 2.0,
//               right: 15,
//               child: Container(
//                 decoration: const BoxDecoration(
//                     shape: BoxShape.circle, color: Colors.red),
//                 width: 18,
//                 height: 14,
//                 child: const Center(),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.shopping_cart, color: Colors.white),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ],
//       //

//       //
//     );
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(50.0);
// }
