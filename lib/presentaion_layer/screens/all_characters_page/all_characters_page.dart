import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty/business_logic_layer/cubit/character_cubit/characters_cubit.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/character_cubit/characters_states.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_cubit.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_states.dart';
import 'package:rick_and_morty/presentaion_layer/screens/all_characters_page/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/numbers.dart';
import '../../../data_layer/models/character_model.dart';

class AllCharactersPage extends StatefulWidget {
  const AllCharactersPage({Key? key}) : super(key: key);

  @override
  State<AllCharactersPage> createState() => _AllCharactersPageState();
}

class _AllCharactersPageState extends State<AllCharactersPage>
    with SingleTickerProviderStateMixin {
  late CharacterCubit _cubit;
  late TabController _tabController;
  int tabBarLength = 2;
  late TextEditingController _searchController;
  late List<Character> allCharacters;
  late List<Character> aliveCharacters;
  late List<Character> deadCharacters;
  late List<Character> filteredCharacters = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<CharacterCubit>(context);
    _cubit.getDeadAndAliveCharacters();
    _tabController = TabController(length: tabBarLength, vsync: this);
    _searchController = TextEditingController();

    allCharacters = _cubit.allcharacters;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
    // buildSearchedItems()
    // );
    _searchController.addListener(() {
      setState(() {});
    });
  }

  addCharacterToFilteredCharactersList(String inputLetter) {
    filteredCharacters = allCharacters
        .where(
            (character) => character.name.toLowerCase().contains(inputLetter))
        .toList();
  }

  bool checkControllerIfEmpty(TextEditingController textEditingController){
    late bool flag;
    textEditingController.text.isEmpty?flag =true:flag=false;
    return flag;
  }
  Widget buildSearchField() {
    ThemeCubit themeCubit = ThemeCubit.getCubit(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor,
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            addCharacterToFilteredCharactersList(value);
            print('all: ${allCharacters.length}');
            print('filtered: ${filteredCharacters.length}');
          });
        },
        controller: _searchController,
        cursorColor:
            themeCubit.state is LightThemeMode ? Colors.black : Colors.white,
        style: TextStyle(
            color: themeCubit.state is LightThemeMode
                ? Colors.black
                : Colors.white),
        decoration: InputDecoration(
          suffixIcon: checkControllerIfEmpty(_searchController)?null:
               InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _searchController.clear();
                    filteredCharacters = [];
                    print(filteredCharacters.length);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  )),

          hintText: 'Rick Sanchez',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor, fontSize: 17),
          prefixIcon: Icon(
            Icons.search,
            color: checkControllerIfEmpty(_searchController)?Theme.of(context).hintColor:Colors.red,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildSearchedItems() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GridViewBuilder(characters: filteredCharacters),
      );
  }

  Widget buildAliveAndDeadView(
      List<Character> aliveCharacters, List<Character> deadCharacters) {
    ThemeCubit themeCubit = ThemeCubit.getCubit(context);
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              GridViewBuilder(characters: aliveCharacters),
              GridViewBuilder(characters: deadCharacters),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterStates>(
      listener: (BuildContext context, CharacterStates state) {
        if (state is DataLoaded) {
          allCharacters = state.allCharacters;
          aliveCharacters = state.aliveCharacters;
          deadCharacters = state.deadCharacters;
        }
      },
      builder: (BuildContext context, CharacterStates state) {
        CharacterCubit characterCubit = CharacterCubit.getCubit(context);
        ThemeCubit themeCubit = ThemeCubit.getCubit(context);
        return Scaffold(
            appBar: PreferredSize(
              preferredSize:  Size.fromHeight(checkControllerIfEmpty(_searchController)?152:110),
              child: Container(
                color: themeCubit.state is LightThemeMode
                    ? Colors.grey[degreeOfGreyColor]
                    : Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    AppBar(
                      elevation: 0.00,
                      backgroundColor: themeCubit.state is LightThemeMode
                          ? Colors.grey[degreeOfGreyColor]
                          : Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                        'Find your favorite character ',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20),
                      ),
                      actions: [
                        BlocBuilder<ThemeCubit, ThemeStates>(
                          builder: (BuildContext context, state) {
                            return IconButton(
                                onPressed: () {
                                  themeCubit.toggleTheme();
                                },
                                icon: state is LightThemeMode
                                    ? const Icon(
                                        Icons.dark_mode,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.light_mode,
                                        color: Colors.white,
                                      ));
                          },
                        )
                      ],
                    ),
                    buildSearchField(),
                    checkControllerIfEmpty(_searchController)?Container(
                      color: themeCubit.state is LightThemeMode
                          ? Colors.grey[degreeOfGreyColor]
                          : Theme.of(context).scaffoldBackgroundColor,
                      child: TabBar(controller: _tabController, tabs: const [
                        Tab(
                          text: 'Alive',
                        ),
                        Tab(
                          text: 'Dead',
                        )
                      ]),
                    ):Container()
                    ,
                  ],
                ),
              ),
            ),
            body: allCharacters.isNotEmpty
                ? GestureDetector(
              onTap: (){
                FocusScopeNode focusScopeNode=FocusScope.of(context);
                if(!focusScopeNode.hasPrimaryFocus){}
                focusScopeNode.unfocus();
              },
                  child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: checkControllerIfEmpty(_searchController)?buildAliveAndDeadView(
                                    aliveCharacters, deadCharacters):buildSearchedItems())
                          ],
                        ),
                      ),
                    ),
                )
                : Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Text(
                              'Loading... ',
                              style: Theme.of(context).textTheme.headline6,
                            )),
                      ),
                    ),
                  ));
      },
    );
  }
}
