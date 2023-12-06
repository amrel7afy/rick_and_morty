import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_states.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data_layer/cache_helper.dart';



class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(InitialThemeMode());
  static ThemeCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);


  void toggleTheme() async {
    if (state is LightThemeMode) {
      await CacheHelper.saveData(key: darkModeKey, value: true); // 1 for dark theme
      emit(DarkThemeMode());
    } else {
      await CacheHelper.saveData(key: darkModeKey, value: false); // 1 for dark theme
      emit(LightThemeMode());
    }
  }


  Future<void> loadTheme() async {
    final savedTheme = CacheHelper.getData(key: darkModeKey) ?? true;
    emit(savedTheme==true? DarkThemeMode() : LightThemeMode()) ;
  }
}