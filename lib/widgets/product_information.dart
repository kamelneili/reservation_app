import 'package:flutter/material.dart';
import 'package:mypfeapp/config/constants.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/models/product_model.dart';
import 'package:readmore/readmore.dart';

import '../config/size_config.dart';

class ProductInformation extends StatelessWidget {
  final Actualite product;
  const ProductInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: kEncodeSansSemiBold.copyWith(
                        color: kDarkBrownColor,
                        fontSize: SizeConfig.blockSizeHorizontal! * 7)),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Actualté Informations',
                    style: kEncodeSansRagular.copyWith(color: kBlackColor)),
                const SizedBox(height: 5),
                // Text(
                //     'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet,',
                //     style: kEncodeSansSemiBold),
                ReadMoreText(
                  product.description,
                  trimLines: 2,
                  trimCollapsedText: ' Read More...',
                  trimExpandedText: ' Show Less',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
    
    //
    
    
    
    
    
   