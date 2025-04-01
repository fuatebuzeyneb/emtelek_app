import 'package:dio/dio.dart';
import 'package:emtelek/core/api/dio_consumer.dart';
import 'package:emtelek/core/utils/routes.dart';
import 'package:emtelek/features/add_listing/data/repositories/property_repository.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/add_listing/presentation/pages/finish_page.dart';
import 'package:emtelek/features/auth/data/repositories/auth_repository.dart';
import 'package:emtelek/features/favorites/data/repositories/favorites_repository.dart';
import 'package:emtelek/features/favorites/domain/cubit/favorites_cubit.dart';
import 'package:emtelek/features/home/data/repositories/home_repository.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/data/repositories/profile_repository.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/features/search_property/data/repositories/search_property_repository.dart';
import 'package:emtelek/shared/common_pages/splash_page.dart';
import 'package:emtelek/shared/cubits/ad_details_cubit/ad_details_cubit.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  await Hive.initFlutter();
  Hive.registerAdapter(CityModelAdapter());
  Hive.registerAdapter(DistrictModelAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PropertyCubit(
            SearchPropertyRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            HomeRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => PropertyAddAdCubit(
            PropertyRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            ProfileRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => MyAdsCubit(
            MyAdsRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(
            FavoritesRepositoryImpl(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(
          create: (context) => AdDetailsCubit(),
        ),
      ],
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizationDelegate(),
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(BlocProvider.of<SettingsCubit>(context).locale),
            // home: FinishPage(),
            routes: routes,
            initialRoute: SplashPage.id,
          );
        },
      ),
    );
  }
}
