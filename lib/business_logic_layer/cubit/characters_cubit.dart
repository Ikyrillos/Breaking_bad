import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/data_layer/models/quote.dart';
import 'package:breaking_bad/data_layer/repos/character_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacter() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
    });
  }
}
