import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/data_layer/models/quote.dart';
import 'package:breaking_bad/data_layer/services/characters_web_service.dart';

class CharactersRepository {
  final CharacterWebService characterWebService;

  CharactersRepository(this.characterWebService);

  Future<List<Character>> getAllCharacters() async {
    final character = await characterWebService.getAllCharacters();
    return character.map((character) => Character.fromJson(character)).toList();
  }
  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await characterWebService.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }
}
