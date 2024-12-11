import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/core/utils/styles.dart';

class TranslationResultSection extends StatelessWidget {
  const TranslationResultSection(
      {super.key, this.translationResult = "Result"});
  final String translationResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              translationResult,
              style: Styles.textStyle20.copyWith(fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: translationResult));
            },
            icon: const Icon(Icons.copy, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
