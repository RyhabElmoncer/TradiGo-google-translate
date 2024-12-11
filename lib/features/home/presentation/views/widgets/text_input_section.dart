import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate_clone/constants.dart';
import 'package:google_translate_clone/core/utils/styles.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_cubit.dart';

class TextInputSection extends StatelessWidget {
  const TextInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: context.read<TranslateCubit>().textController,
              maxLines: 5,
              minLines: 1,
              onSubmitted: (value) {
                BlocProvider.of<TranslateCubit>(context)
                    .translate("en", "ar", value);
              },
              decoration: InputDecoration(
                hintText: "Enter text",
                hintStyle: Styles.textStyle20.copyWith(
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              ClipboardData? clipboardData =
                  await Clipboard.getData('text/plain');
              if (clipboardData != null) {
                context.read<TranslateCubit>().textController.text =
                    clipboardData.text!;
              }
            },
            icon: const Icon(
              Icons.paste,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
