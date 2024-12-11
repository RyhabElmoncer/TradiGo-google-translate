import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/core/utils/styles.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_cubit.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_state.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/language_selection_section.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/text_input_section.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/translate_result.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: BlocBuilder<TranslateCubit, TranslateState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LanguageSelectionSection(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter text to translate:",
                        style: Styles.textStyle20.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const TextInputSection(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<TranslateCubit>(context).translate(
                          BlocProvider.of<TranslateCubit>(context)
                              .fromLanguage
                              .code,
                          BlocProvider.of<TranslateCubit>(context)
                              .toLanguage
                              .code,
                          BlocProvider.of<TranslateCubit>(context)
                              .textController
                              .text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      child: Text(
                        "Translate",
                        style: Styles.textStyle32.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    if (state is TranslateSuccessState)
                      TranslationResultSection(
                        translationResult: state.translationModel.translation,
                      ),
                    if (state is TranslateFailureState)
                      Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
