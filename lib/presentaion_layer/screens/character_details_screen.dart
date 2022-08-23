import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic_layer/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character? character;
  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character!.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          title: 'Jobs: ', value: character!.jobs.join(' / ')),
                      buildDivider(280),
                      characterInfo(
                          title: 'Appeared in: ',
                          value: character!.categoryOfTwoSeries),
                      buildDivider(240),
                      characterInfo(
                          title: 'Status: ',
                          value: character!.statusIfDeadOrAlive),
                      buildDivider(260),
                      character!.betterCallSaulAppearnce.isEmpty
                          ? const SizedBox()
                          : characterInfo(
                              title: 'Better Call Saul Seasons: ',
                              value: character!.betterCallSaulAppearnce
                                  .join(' / ')),
                      character!.betterCallSaulAppearnce.isEmpty
                          ? const SizedBox()
                          : buildDivider(120),
                      characterInfo(
                          title: 'Seasons: ',
                          value: character!.appearanceOfSeasons.join(' / ')),
                      buildDivider(250),
                      characterInfo(
                          title: 'Actor/Actress: ',
                          value: character!.actorName),
                      buildDivider(200),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character!.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character!.charId,
          child: Image.network(
            character!.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      thickness: 2,
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            displayFullTextOnTap: true,
            pause: const Duration(milliseconds: 1000),
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote,
                  speed: const Duration(milliseconds: 2000 * 3)),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myWhite),
    );
  }
}
