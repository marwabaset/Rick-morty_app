import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rickandmorty_app/constants/colors.dart';
import 'package:rickandmorty_app/constants/strings.dart';
import 'package:rickandmorty_app/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScreen,
            arguments: character),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: character.image.isNotEmpty
                ? Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Lottie.asset(
                          'assets/lottie/lottieflow-loading-06-000000-easey.json',
                          width: 100,
                          height: 100,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print("Image load error: $error");
                      return Image.asset(
                        'assets/images/202.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/202.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
