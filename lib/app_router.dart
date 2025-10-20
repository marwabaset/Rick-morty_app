import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_app/business_logic/characters_cubit.dart';
import 'package:rickandmorty_app/constants/strings.dart';
import 'package:rickandmorty_app/data/models/characters.dart';
import 'package:rickandmorty_app/data/repository/characters_repo.dart';
import 'package:rickandmorty_app/data/web_services/character_web_ser.dart';
import 'package:rickandmorty_app/presentation/screens/characters_details.dart';
import 'package:rickandmorty_app/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(charactersRepository),
                  child: const CharactersScreen(),
                ));

      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>  BlocProvider(
          create: (context) =>  CharactersCubit(charactersRepository),
          child: CharactersDetails(
            character:character)));
    }
   
  }
}
