import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/core/utils/styles.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';

class LanguageList extends StatelessWidget {
  final List<LanguageModel> languages;
  final void Function(LanguageModel) onLanguageTap;

  const LanguageList({
    super.key,
    required this.languages,
    required this.onLanguageTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 60.0,
              child: FadeInAnimation(
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    title: Text(
                      languages[index].name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      languages[index].code,
                      style: Styles.textStyle20.copyWith(fontSize: 16),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: kPrimaryColor),
                    onTap: () => onLanguageTap(languages[index]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
