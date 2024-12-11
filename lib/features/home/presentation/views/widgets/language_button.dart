import 'package:flutter/material.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/core/utils/styles.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';
import 'package:google_translate_clone/features/home/presentation/views/select_language_view.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.language,
    required this.context,
    required this.callback,
  });

  final String language;
  final BuildContext context;
  final void Function(LanguageModel) callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectLanguageView(callback: callback),
          ),
        );
      },
      child: Container(
        height: 50,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade700.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            language,
            style: Styles.textStyle32.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
