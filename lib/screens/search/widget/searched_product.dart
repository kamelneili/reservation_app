import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

class SearchedProduct extends StatelessWidget {
  final Actualite product;
  const SearchedProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.image,
                fit: BoxFit.contain,
                height: 135.h,
                width: 135.w,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 235.w,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                        maxLines: 2,
                      ),
                    ),

                    Container(
                      width: 235.w,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "${product.price} DT",
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    // Container(
                    //   width: 235.w,
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: const Text('Eligible for FREE Shipping'),
                    // ),

                    Container(
                      width: 235.w,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        'disponible',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
