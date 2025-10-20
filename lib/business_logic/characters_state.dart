part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoded extends CharactersState {
  final List<Character> characters;

  CharacterLoded(this.characters);

  
}
class QuotesLoded extends CharactersState {
  final Quotes quotes;

  QuotesLoded(this.quotes);

  
}
