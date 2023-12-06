import '../../../data_layer/models/character_model.dart';

abstract class CharacterStates {}

class CharactersInitialState extends CharacterStates {}
class ChangeThemeMode extends CharacterStates {}

class DataLoaded extends CharacterStates {
  late List<Character> allCharacters;
  late List<Character> aliveCharacters;
  late List<Character> deadCharacters;

  DataLoaded(
      {required this.allCharacters,
      required this.aliveCharacters,
      required this.deadCharacters});
}

class CharactersLoadedState extends CharacterStates {
  late List<Character> characters;

  CharactersLoadedState(this.characters);
}

class CharactersErrorState extends CharacterStates {
  late String error;

  CharactersErrorState(this.error) {
    print(error);
  }
}

class AliveCharactersLoadedState extends CharacterStates {
  late List<Character> characters;

  AliveCharactersLoadedState(this.characters);
}

class AliveCharactersErrorState extends CharacterStates {
  late String error;

  AliveCharactersErrorState(this.error) {
    print(error);
  }
}

class DeadCharactersLoadedState extends CharacterStates {
  late List<Character> characters;

  DeadCharactersLoadedState(this.characters);
}

class DeadCharactersErrorState extends CharacterStates {
  late String error;

  DeadCharactersErrorState(this.error) {
    print(error);
  }
}
