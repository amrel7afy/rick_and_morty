import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/AppRouter.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/character_cubit/characters_cubit.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_cubit.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_states.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/constants/themes/dark_theme.dart';
import 'package:rick_and_morty/constants/themes/light_theme.dart';
import 'package:rick_and_morty/data_layer/cache_helper.dart';
import 'package:rick_and_morty/data_layer/web_services/web_services_helper.dart';
import 'package:flutter/material.dart';

import 'business_logic_layer/bloc_observer.dart';
import 'business_logic_layer/cubit/character_cubit/characters_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(RickAndMortyApp(
    AppRouter(WebServices()),
  ));
}

class RickAndMortyApp extends StatelessWidget {
  late AppRouter appRouter;

  RickAndMortyApp(
    this.appRouter, {
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => CharacterCubit(WebServices())),
        BlocProvider(
            create: (BuildContext context) => ThemeCubit()..loadTheme())
      ],
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (BuildContext context, state) {
          print(state);
          ThemeCubit cubit = ThemeCubit.getCubit(context);
          return MaterialApp(
            onGenerateRoute: appRouter.generateRoute,
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state is LightThemeMode ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
