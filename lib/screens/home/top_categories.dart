import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypfeapp/blocs/category/category_bloc.dart';
import 'package:mypfeapp/config/constants.dart';

import '../../../blocs/category/category_event.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  List<String> categories = [
    "Chambres",
    "Hotels",
    "Villa",
    "Appartements",
    "Maison d'hôte"
  ];

  List<String> icons = [
    "All items_icon",
    "Dress_icon",
    "Hat_icon",
    "Watch_icon"
  ];

  int current = 0;
  final String category = '';
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 38.h,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    current = index;
                  });

                  context.read<CategoryBloc>().add(
                      LoadCategoryProductEvent(category: categories[current]));
                  // navigateToCategoryPage(context, categories[index]);
                  Navigator.of(context).pushNamed('/category-deals',
                      arguments: categories[current]);
                  print(categories[current]);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  margin: EdgeInsets.only(
                      left: index == 0 ? kPaddingHorizontal : 15.w,
                      right: index == categories.length - 1
                          ? kPaddingHorizontal
                          : 0),
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: current == index ? kBrownColor : kGreysColor,
                    borderRadius: BorderRadius.circular(8),
                    border: current == index
                        ? null
                        : Border.all(
                            color: kLightGreyColor,
                            width: 1.w,
                          ),
                  ),
                  child: Text(categories[index],
                      style: current == index
                          ? kEncodeSansMedium.copyWith(
                              color: current == index
                                  ? kWhiteColor
                                  : kDarkBrownColor,
                              fontSize: 16.sp,
                              //SizeConfig.blockSizeHorizontal! * 3,
                            )
                          : kEncodeSansRagular.copyWith(
                              color: current == index
                                  ? kWhiteColor
                                  : kDarkBrownColor,
                              fontSize: 16.sp,
                              //SizeConfig.blockSizeHorizontal! * 3,
                            )),
                ),
              )),
        ));
  }
}
