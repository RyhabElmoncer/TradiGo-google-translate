import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_cubit.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_state.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/language_button.dart';

class LanguageSelectionSection extends StatelessWidget {
  const LanguageSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LanguageButton(
                language:
                    BlocProvider.of<TranslateCubit>(context).fromLanguage.name,
                context: context,
                callback: (LanguageModel selectedLanguage) {
                  BlocProvider.of<TranslateCubit>(context)
                      .updateFromLanguage(selectedLanguage);
                },
              ),
              const Spacer(),
              IconButton(
                onPressed:
                    BlocProvider.of<TranslateCubit>(context).swapLanguages,
                icon: const Icon(
                  Icons.compare_arrows,
                  color: kPrimaryColor,
                ),
              ),
              const Spacer(),
              LanguageButton(
                language:
                    BlocProvider.of<TranslateCubit>(context).toLanguage.name,
                context: context,
                callback: (LanguageModel selectedLanguage) {
                  BlocProvider.of<TranslateCubit>(context)
                      .updateToLanguage(selectedLanguage);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
