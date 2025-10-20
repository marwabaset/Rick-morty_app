import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty_app/data/models/characters.dart';
import 'package:rickandmorty_app/data/models/quotes.dart';
import 'package:rickandmorty_app/data/repository/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  //List<Quotes> quotes = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersRepository.getAllCharacters();
    emit(CharacterLoded(characters));
    this.characters = characters;
    return characters;
  }

  void getCharactersQuotes(String characterId) {
    charactersRepository.getCharactersQuotes(characterId).then((quote) {
      emit(QuotesLoded(quote));
    });
  }

  

 
}
