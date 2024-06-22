import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypfeapp/home/category_deals_screen.dart';
import 'package:mypfeapp/home/deal_of_day.dart';
import 'package:mypfeapp/home/home_screen.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/models/product_model.dart';
import 'package:mypfeapp/profile/profile_screen.dart';
import 'package:mypfeapp/screens/account/account_screen.dart';
import 'package:mypfeapp/screens/basket/basket_screen.dart';
import 'package:mypfeapp/screens/delivery_time/delivery_time_screen.dart';
import 'package:mypfeapp/screens/home/new_product_screen.dart';
import 'package:mypfeapp/screens/login/login_screen.dart';
import 'package:mypfeapp/screens/product_details/product_details_screen.dart';
import 'package:mypfeapp/screens/search/screens/search_screen.dart';
import 'package:mypfeapp/screens/signup/signup_screen.dart';
import 'package:mypfeapp/screens/splash/splash_screen.dart';
import 'package:mypfeapp/screens/wishlist/wishlist_screen.dart';
import 'package:mypfeapp/widgets/contact_us.dart';

import 'screens/home/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/newact':
        return MaterialPageRoute(
          builder: (_) => NewProductScreen(),
        );
      case '/search-screen':
        return MaterialPageRoute(
          builder: (_) => SearchScreen(
            searchQuery: settings.arguments as String,
          ),
        );
      case '/category-deals':
        return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
            category: settings.arguments as String,
          ),
        );
      //WishlistScreen
      case '/wishlist':
        return MaterialPageRoute(
          builder: (_) => const WishlistScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/ProductDetails':
        return MaterialPageRoute(
          builder: (_) => ProductDetails(
            product: settings.arguments as Actualite,
          ),
        );
      case '/basket':
        return MaterialPageRoute(
          builder: (_) => const BasketScreen(),
        );
      case '/delivery_time':
        return MaterialPageRoute(
          builder: (_) =>
              DeliveryTimeScreen(product: settings.arguments as Actualite),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case '/account':
        return MaterialPageRoute(
          builder: (_) => const AccountScreen(),
        );
      case '/loginScreen':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/SignupScreen':
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case '/ProfileScreen':
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case '/contactInformation':
        return MaterialPageRoute(
          builder: (_) => const ContactInformation(),
        );
    }
    return null;
  }
}
