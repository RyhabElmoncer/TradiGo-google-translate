import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate_clone/core/error/failuer.dart';
import 'package:google_translate_clone/features/home/data/repository/translation_repository.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';
import 'package:google_translate_clone/features/home/data/view_model/translate_model.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TranslationRepository translationRepository;
  final TextEditingController textController = TextEditingController();
  LanguageModel fromLanguage = LanguageModel(code: "ar", name: "Arabic");
  LanguageModel toLanguage = LanguageModel(code: "en", name: "English");

  TranslateCubit(this.translationRepository) : super(TranslateInitialState());

  Future<void> translate(String from, String to, String query) async {
    emit(TranslateLoadingState());

    final Either<Failure, TranslationModel> result =
        await translationRepository.translate(from, to, query);

    result.fold(
      (failure) => emit(TranslateFailureState(failure.message)),
      (translationModel) => emit(TranslateSuccessState(translationModel)),
    );
  }

  Future<List<LanguageModel>> loadLanguages() async {
    return await translationRepository.loadLanguages();
  }

  void updateFromLanguage(LanguageModel language) {
    fromLanguage = language;
    emit(TranslateLanguageUpdatedState());
  }

  void updateToLanguage(LanguageModel language) {
    toLanguage = language;
    emit(TranslateLanguageUpdatedState());
  }

  void swapLanguages() {
    final temp = fromLanguage;
    fromLanguage = toLanguage;
    toLanguage = temp;
    emit(TranslateLanguageUpdatedState());
  }
}
