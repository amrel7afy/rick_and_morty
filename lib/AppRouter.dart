import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_cubit.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data_layer/web_services/web_services_helper.dart';
import 'package:rick_and_morty/presentaion_layer/screens/all_characters_page/all_characters_page.dart';
import 'package:rick_and_morty/presentaion_layer/screens/character_details_page/character_details_page.dart';
import 'package:rick_and_morty/presentaion_layer/screens/splash_page/splash_page.dart';

import 'business_logic_layer/cubit/character_cubit/characters_cubit.dart';
import 'data_layer/models/character_model.dart';

class AppRouter {
  late final WebServices _webServices;

  AppRouter(this._webServices);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case showCharacters:
        return MaterialPageRoute(
            builder: (context) =>

                BlocProvider(create: (BuildContext context)=>CharacterCubit(_webServices),child:const AllCharactersPage() ),);




      case characterDetailsPage:
        final Character character=settings.arguments as Character;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) => CharacterCubit(_webServices),
                child:  CharacterPage(character: character)));
    }
    return null;
  }
}
