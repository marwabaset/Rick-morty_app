import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_app/business_logic/characters_cubit.dart';
import 'package:rickandmorty_app/constants/colors.dart';
import 'package:rickandmorty_app/data/models/characters.dart';

class CharactersDetails extends StatelessWidget {
  final Character character;

  const CharactersDetails({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.background,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   character.name,
        //   textAlign: TextAlign.left,
        // ),
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: const TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYello,
      thickness: 2,
    );
  }

  Widget checkIfQuotesLoaded(CharactersState state) {
    if (state is QuotesLoded) {
      return displayRandomQuotes(state);
    } else {
      return showProgressIndictor();
    }
  }

  Widget displayRandomQuotes(state) {
    var loc = (state).quotes;
    //  if (loc.length != 0) {
    // int randomQuotesIndex = Random().nextInt(loc.length - 1);
    return Center(
      child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style:
              const TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
            Shadow(
              blurRadius: 7,
              color: MyColors.myYello,
              offset: Offset(0, 0),
            )
          ]),
          child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [FlickerAnimatedText(loc.quote)])),
    );
    // } else {
    //   return Container();
    // }
  }

  Widget showProgressIndictor() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYello,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getCharactersQuotes(character.id.toString());
    return Scaffold(
      backgroundColor: MyColors.background,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Name:', character.name),
                  buildDivider(200),
                  characterInfo('Status:', character.status),
                  buildDivider(150),
                  characterInfo('Species:', character.species),
                  buildDivider(100),
                  characterInfo('Gender:', character.gender),
                  buildDivider(50),
                  BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                    return checkIfQuotesLoaded(state);
                  })
                ],
              ),
            ),
            const SizedBox(
              height: 300,
            )
          ]))
        ],
      ),
    );
  }
}
