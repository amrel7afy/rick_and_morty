import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data_layer/models/character_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class CharacterItemBuilder extends StatelessWidget {
   final Character character;

  const CharacterItemBuilder({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, characterDetailsPage,arguments:character );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: character.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                        
                //Image.network(character.image,fit: BoxFit.cover,)
                FadeInImage.memoryNetwork(placeholder:kTransparentImage , image: character.image,fit: BoxFit.cover,)
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            character.name,
            style:  Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class GridViewBuilder extends StatelessWidget {
   final List<Character> characters;

  const GridViewBuilder({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          const WovenGridTile(
            4 /6 ,
            crossAxisRatio: 1,
            alignment: AlignmentDirectional.centerEnd,
          ),const WovenGridTile(.8),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: characters.length,
        (context, index) {
         return CharacterItemBuilder(
            character: characters[index],
          );
        },

      ),
    );
  }
}

/*class SearchBuilder extends StatefulWidget {
  static  final TextEditingController editingController=TextEditingController();
  late List<Character>allCharacters;
  static List<Character>filteredCharacters=[];
    SearchBuilder(this.allCharacters,{Key? key}) : super(key: key);

  @override
  State<SearchBuilder> createState() => _SearchBuilderState(allCharacters,);
}

class _SearchBuilderState extends State<SearchBuilder> {
  _SearchBuilderState(this.allCharacters);
   late List<Character>allCharacters;
  static late List<Character>filteredCharacters;
  addCharacterToFilteredCharactersList(String inputLetter) {
    filteredCharacters = allCharacters
        .where(
            (character) => character.name.toLowerCase().contains(inputLetter))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xff1e1c2c)),
      child: TextField(
        onChanged: (value){
          setState(() {
            addCharacterToFilteredCharactersList(value);
             print('all: ${allCharacters.length}');
             print('filtered: ${filteredCharacters.length}');
          });
        },
        controller: SearchBuilder.editingController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Rick Sanchez',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey[600]!.withOpacity(0.5)),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white.withOpacity(0.8),
          ),
          suffixIcon:filteredCharacters.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                filteredCharacters = [];
                _textEditingController.clear();
              });
            },
            icon: const Icon(Icons.clear, color: Colors.red),
          )
              : null,
          ,
          suffixIconColor: Colors.red,
          border: InputBorder.none,
        ),
      ),
    );
  }
}*/
