import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mypfeapp/blocs/category/category_bloc.dart';
import 'package:mypfeapp/blocs/category/category_state.dart';
import 'package:mypfeapp/config/constants.dart';
import 'package:mypfeapp/config/newsCardSkelton.dart';
import 'package:mypfeapp/home/blocs/actualite_bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      print('state:$state');
      print("catstate");
      if (state is CategoryProductLoadingState) {
        return ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) => const NewsCardSkelton(),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      }
      if (state is CategoryProductLoadedState) {
        return Container(
          child: MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 23,
            itemCount: state.acts.length,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/ProductDetailsScreen',
                    arguments: state.acts[index],
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              child: Image(
                                height: 124.h,
                                width: 161.w,
                                fit: BoxFit.fill,
                                image: NetworkImage(state.acts[index].image[0]),
                              )),
                        ),
                        Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                                // onTap: () {},
                                // child: const Image(
                                //   height: 20,
                                //   width: 20,
                                //   image: AssetImage(
                                //       'assets/images/unselected_favourite.png'),
                                // ),
                                ))
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.acts[index].name,
                                style: kEncodeSansCondensedThin.copyWith(
                                  color: kDarkBrownColor,
                                  fontSize: 16.sp,
                                )),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text("${state.acts[index].price} DT",
                                style: kEncodeSansSemiBold.copyWith(
                                  color: kBlackColor,
                                  fontSize: 12.sp,
                                  //SizeConfig.blockSizeHorizontal! * 3.5,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return const Text('Something went wrong.');
      }
    });
  }
}
