import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/character_cubit/characters_states.dart';
import 'package:rick_and_morty/data_layer/cache_helper.dart';
import 'package:rick_and_morty/data_layer/web_services/web_services_helper.dart';

import '../../../constants/strings.dart';
import '../../../data_layer/models/character_model.dart';



class CharacterCubit extends Cubit<CharacterStates> {
  late WebServices webServices;

   bool appDarkMode=false;

  CharacterCubit(this.webServices) : super(CharactersInitialState());



  static CharacterCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);
  List<Character> allcharacters = [];
  List<Character> aliveCharacters = [];
  List<Character> deadCharacters = [];

  Future<dynamic> getAllCharacters() async {
    await webServices.getData(url: allCharacter).then((value) {
      var characters = value.data['results'] as List;
      this.allcharacters =
          characters.map((character) => Character.fromJson(character)).toList();
      emit(CharactersLoadedState(this.allcharacters));
    }).catchError((error) {
      emit(CharactersErrorState(error.toString()));
    });
  }
  void changeThemeMode() async{
    print('Before cache : $appDarkMode');
    appDarkMode=!appDarkMode;
   await CacheHelper.saveData(
      key: darkModeKey,
      value: appDarkMode,
    ).then((value) => emit(ChangeThemeMode()));
    print('After cache : $appDarkMode');
  }

  Future<dynamic> getDeadCharacters() async {
    await webServices
        .getData(url: allCharacter, query: {'status': 'dead'}).then((value) {
      var deadCharacters = value.data['results'] as List;
      this.deadCharacters = deadCharacters
          .map((character) => Character.fromJson(character))
          .toList();
      print('aliveCharacters');
      print(this.deadCharacters.length);
    }).catchError((error) {
      emit(AliveCharactersErrorState(error.toString()));
    });
  }

  void getDeadAndAliveCharacters() async {
    /*for (var element in characters) {
      aliveCharacters.add(element);
      if (element.status == 'Alive') {
        aliveCharacters.add(element);
      } else {
        deadCharacters.add(element);
      }
    }
    print('Alive : ${aliveCharacters.length}');
    print('Dead : ${deadCharacters.length}');
  }*/
    await webServices.getData(
        url: allCharacter, query: {'status': 'alive'}).then((value) async {
      var aliveCharacters = value.data['results'] as List;
      this.aliveCharacters = aliveCharacters
          .map((character) => Character.fromJson(character))
          .toList();
      print('aliveCharacters');
      print(this.aliveCharacters.length);
      await getDeadCharacters();
      await getAllCharacters();
      emit(DataLoaded(
          allCharacters: allcharacters,
          aliveCharacters: this.aliveCharacters,
          deadCharacters: deadCharacters));
    }).catchError((error) {
      emit(AliveCharactersErrorState(error.toString()));
    });
  }

  Future<void> getBooleanValue() async {
    // Retrieve the boolean value from SharedPreferences
    bool? storedValue = await CacheHelper.sharedPreferences?.getBool(darkModeKey);
    appDarkMode = storedValue ?? false;
  }


}
