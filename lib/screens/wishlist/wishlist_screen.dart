import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/wishlist/wishlist_bloc.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  const WishlistScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  bottomNavigationBar: CustomNavBar(screen: routeName),
        body: BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is WishlistLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.25,
              ),
              itemCount: state.wishlist.actualites.length,
              itemBuilder: (BuildContext context, int index) {
                return const Center(child: Text("hi")
                    // child: ProductCard.wishlist(
                    //   product: state.wishlist.actualites[index],
                    // )
                    );
              },
            ),
          );
        }
        return const Text('Something went wrong!');
      },
    ));
  }
}
