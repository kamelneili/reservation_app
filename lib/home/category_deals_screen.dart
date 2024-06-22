import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypfeapp/blocs/category/category_bloc.dart';
import 'package:mypfeapp/blocs/category/category_state.dart';
import 'package:mypfeapp/config/newsCardSkelton.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color(0xFFfed9cd),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Nos ${widget.category}',
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
          SizedBox(
            height: 170.h,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryProductLoadingState) {
                  return ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const NewsCardSkelton(),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                  );
                }
                if (state is CategoryProductLoadedState) {
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: state.acts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    state.acts[index].image,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                state.acts[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("something went wrong");
                }
              },
            ),
          ),
          //
        ],
      ),
    );
  }
}
