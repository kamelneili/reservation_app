import 'package:flutter/material.dart';
import 'package:mypfeapp/config/skeleton.dart';

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Skeleton(height: 120, width: 120),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: 80),
              SizedBox(height: 20 / 2),
              Skeleton(),
              SizedBox(height: 20 / 2),
              Skeleton(),
              SizedBox(height: 20 / 2),
              Row(
                children: [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
