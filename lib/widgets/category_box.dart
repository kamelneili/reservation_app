import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypfeapp/models/category_model.dart';

import '../models/product_model.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // List<Product> restaurants = Product.produits
    //     .where(
    //       (restaurant) => restaurant.tags.contains(category.name),
    //     )
    //     .toList();
    return InkWell(
      onTap: () {
        //  Navigator.pushNamed(context, '/produit-listing',
        //     arguments: products);
      },
      child: Container(
          width: 80,
          margin: const EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  height: 50.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(category.image.toString()),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    category.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
