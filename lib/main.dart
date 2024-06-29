// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mypfeapp/app_router.dart';
import 'package:mypfeapp/blocs/appointment/appointment_event.dart';
import 'package:mypfeapp/blocs/auth/auth_bloc.dart';
import 'package:mypfeapp/blocs/category/category_bloc.dart';
import 'package:mypfeapp/blocs/cubits/login/login_cubit.dart';
import 'package:mypfeapp/blocs/cubits/signup/signup_cubit.dart';
import 'package:mypfeapp/blocs/rating/rating_bloc.dart';
import 'package:mypfeapp/blocs/search/search_bloc.dart';
import 'package:mypfeapp/blocs/wishlist/wishlist_bloc.dart';
import 'package:mypfeapp/config/theme.dart';
import 'package:mypfeapp/home/blocs/actualite_bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_event.dart';
import 'package:mypfeapp/home/home_screen.dart';
import 'package:mypfeapp/home/repositories/actualite_repository.dart';
import 'package:mypfeapp/repositories/appointment/appointment_repository.dart';
import 'package:mypfeapp/repositories/local_storage/local_storage_repository.dart';
import 'package:mypfeapp/repositories/search_repository.dart';
import 'package:mypfeapp/screens/home/home_screen.dart';
import 'package:mypfeapp/screens/signup/signup_screen.dart';
import 'package:mypfeapp/screens/splash/splash_screen.dart';
import 'package:mypfeapp/translations/codegen_loader.g.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mypfeapp/local_push_notification.dart';

import 'blocs/appointment/appointment_bloc.dart';
import 'blocs/basket/basket_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'repositories/repositories.dart';
import 'repositories/services/storage_service.dart';
import 'repositories/user/user_repository.dart';

import 'package:easy_localization/easy_localization.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// On click listner
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  // Hive.registerAdapter(ProductAdapter());
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black26));
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  //await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
  //LocalNotificationService.initialize();
  //await GetStorage.init();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  //await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  //await ServiceFirebaseMessages.getToken();
  await ScreenUtil.ensureScreenSize();
  runApp(EasyLocalization(
      path: 'assets/translations',
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('fr'),
        const Locale('de'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MyApp(
        appRouter: AppRouter(),
      )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.appRouter,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => AppointmentRepository(),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => StorageRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                  userRepository: context.read<UserRepository>(),
                  storageRepository: context.read<StorageRepository>()),
            ),
            BlocProvider(
              create: (context) => LoginCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(
                create: (_) =>
                    CategoryBloc(actRepository: ActualiteRepository())
                //  ..add(LoadingCategoryProductEvent()),
                ),
            BlocProvider(
                create: (_) =>
                    SearchBloc(searchRepository: SearchRepository())),

            BlocProvider(
                create: (_) =>
                    RatingBloc(actRepository: ActualiteRepository())),

            BlocProvider(
              create: (context) => ProfileBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                userRepository: context.read<UserRepository>(),
              )..add(
                  LoadProfile(auth.FirebaseAuth.instance.currentUser),
                ),
            ),

            BlocProvider(create: (context) => BasketBloc()..add(StartBasket())),
            BlocProvider(
              create: (context) =>
                  ActualiteBloc(actualiteRepository: ActualiteRepository())
                    ..add(const LoadActualite()),
            ),
            BlocProvider(
              create: (context) => SignupCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(
              create: (_) => WishlistBloc(
                localStorageRepository: LocalStorageRepository(),
              )..add(StartWishlist()),
            ),
            BlocProvider(
                create: (context) => AppointmentBloc(
                      appointmentRepository:
                          context.read<AppointmentRepository>(),
                    )..add(LoadAppointments(
                        context.read<AuthBloc>().state.authUser))),

            // BlocProvider(
            //     create: (context) => AuthBloc(
            //           userRepository: UserRepository(),
            //           //   databaseRepository: DatabaseRepository()
            //         )),
            // BlocProvider(
            //     create: (context) => UserBloc(
            // // userRepository: UserRepository(),
            // databaseRepository: DatabaseRepository()))
          ],
          child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              child: MaterialApp(
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: appRouter.generateRoute,
                home: SplashScreen(),
                routes: {
                  "home_screen": (context) => HomeScreen(),
                },
              )),
        ),
      ),
    );
  }
}
