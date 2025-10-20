import 'package:rickandmorty_app/data/models/characters.dart';
import 'package:rickandmorty_app/data/models/quotes.dart';
import 'package:rickandmorty_app/data/web_services/character_web_ser.dart';

class CharactersRepository {
  final CharacterWebServices characterWebServices;

  CharactersRepository(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<Quotes>getCharactersQuotes(String id) async {
    final json = await characterWebServices.getCharactersQuotes(id);
    print('QQ isss $json');
    return Quotes.fromJson(json);
  }
}
