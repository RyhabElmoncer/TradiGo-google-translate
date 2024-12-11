import 'package:dartz/dartz.dart';
import 'package:google_translate_clone/core/error/failuer.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';
import 'package:google_translate_clone/features/home/data/view_model/translate_model.dart';

abstract class TranslationRepository {
  Future<Either<Failure, TranslationModel>> translate(
      String from, String to, String query);

  Future<List<LanguageModel>> loadLanguages();
}
