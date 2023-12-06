import 'package:flutter/material.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_cubit.dart';
import 'package:rick_and_morty/business_logic_layer/cubit/theme_cubit/theme_states.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';

import '../../../data_layer/models/character_model.dart';


class CharacterPage extends StatefulWidget {
  late Character character;

  CharacterPage({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterPage> createState() =>
      _CharacterPageState(character: character);
}

class _CharacterPageState extends State<CharacterPage> {
  late Character character;
  _CharacterPageState({required this.character});

  Widget buildElevatedCard(String text,ThemeCubit themeCubit) {
    return Container(
      width: text == 'Female' ? 60 : 50,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border:   Border(
              top: BorderSide(
                color: themeCubit.state is DarkThemeMode?Colors.grey:Colors.black,
              ),
              left: BorderSide(color:  themeCubit.state is DarkThemeMode?Colors.grey:Colors.black)),
          boxShadow: [
            BoxShadow(
              color: themeCubit.state is DarkThemeMode?Colors.grey.withOpacity(0.1):Colors.grey.withOpacity(0.6),
              // Shadow color with opacity
              blurRadius: .5, // Spread of the shadow
            ),
          ]),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color:themeCubit.state is DarkThemeMode?Colors.grey:Colors.white
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit =ThemeCubit.getCubit(context);
    return Scaffold(
      body: SafeArea(
        child: SliverSnap(
          onCollapseStateChanged: (isCollapsed, scrollingOffset, maxExtent) {},
          collapsedBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedBackgroundColor: Colors.transparent,
          backdropWidget: SizedBox(
              width: double.infinity,
              child: Hero(
                  tag: character.image,
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                  ))),
          /*bottom:  PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                height: 20,
                color: Colors.red,
              ),
            ),*/
          expandedContentHeight: 280,
          expandedContent: Container(),
          collapsedContent: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.red, size: 30)),
          body: Container(
            padding: const EdgeInsets.all(25),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            character.name,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Status :   ',
                            style: Theme.of(context).textTheme.headline6!.copyWith(),
                          ),
                          buildElevatedCard(character.status,themeCubit)
                        ],
                      ),
                    ),

                  ],
                ),
                ///////////////////////////////////////////////////////////////
                Divider(
                  color: Theme.of(context).highlightColor,
                  thickness: 1,
                  height: 30,
                  indent: 10,
                  endIndent: 15,
                ),
                ////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Origin',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            character.origin.name,
                            style:
                                Theme.of(context).textTheme.bodyText1!,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(children: [Text(
                        'Gender : ',
                        style: Theme.of(context).textTheme.headline6!.copyWith(),
                      ),
                        buildElevatedCard(character.gender,themeCubit)],),
                    )

                  ],
                )
              ],
            ),
          ),
        )

      ),
    );
  }
}
