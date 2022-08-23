import 'package:breaking_bad/business_logic_layer/cubit/characters_cubit.dart';
import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/data_layer/repos/character_repo.dart';
import 'package:breaking_bad/data_layer/services/characters_web_service.dart';
import 'package:breaking_bad/presentaion_layer/screens/character_details_screen.dart';
import 'package:breaking_bad/presentaion_layer/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharacterWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharacterScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
              create: (BuildContext context) => CharactersCubit(charactersRepository),
              child: CharacterDetailsScreen(
                    character: character,
                  ),
            ));
    }
    return null;
  }
}
