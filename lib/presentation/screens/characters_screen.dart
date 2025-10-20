import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_app/business_logic/characters_cubit.dart';
import 'package:rickandmorty_app/constants/colors.dart';
import 'package:rickandmorty_app/data/models/characters.dart';
import 'package:rickandmorty_app/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  // 🔍 Search
  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      onChanged: (searchCharacters) {
        addSearchedFOrItemsToSearchedList(searchCharacters);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchCharacters) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchCharacters))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
            size: 25,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() => _isSearching = true);
  }

  void _stopSearching() {
    _clearSearch();
    setState(() => _isSearching = false);
  }

  void _clearSearch() => _searchTextController.clear();

  Widget BuildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterLoded) {
          allCharacters = state.characters;
          return buildListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.background,
        child: Column(children: [buildCharacterList()]),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchForCharacters[index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYello),
    );
  }

  Widget buildAppBarTitle() {
    return Center(
      child: const Text(
        'Characters',
        style: TextStyle(
          color: Color.fromARGB(255, 50, 50, 48),
          fontWeight: FontWeight.w700,
          fontSize: 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.myYello,
        automaticallyImplyLeading: false,
        leading:
            _isSearching ? BackButton(color: MyColors.myGrey) : Container(),
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.zero,
            child: _isSearching ? _buildSearchField() : buildAppBarTitle(),
          ),
        ),
        actions: _buildAppBarActions(),
      ),
      body: BuildBlocWidget(),
    );
  }
}
