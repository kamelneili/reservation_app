import 'package:flutter/material.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

class ActualiteCard extends StatelessWidget {
  final Actualite actualite;
  const ActualiteCard({
    super.key,
    required this.actualite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.pushNamed(context, '/product_details', arguments: product);
      },
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/ProductDetails',
                arguments: actualite,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),

              child: Image.network(actualite.image,
                  fit: BoxFit.cover, width: 1000.0),
              // child: Text(serveur.name),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Container(
                color: const Color.fromRGBO(170, 140, 140, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(actualite.price!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Text("DT",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(actualite.nbprs,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Text("pers",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),

                      // Container(
                      //   child:
                      //       Center(child: Icon(Icons.favorite, color: Colors.red)),
                      // ),
                      // Container(
                      //   child:
                      //       Center(child: Icon(Icons.favorite, color: Colors.red)),
                      // ),

                      Flexible(
                        child: Text(actualite.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
