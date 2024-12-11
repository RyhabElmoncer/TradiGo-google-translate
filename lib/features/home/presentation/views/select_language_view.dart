import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate_clone/features/home/data/view_model/language_model.dart';
import 'package:google_translate_clone/features/home/presentation/controller/translate_cubit.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/language_list.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/search_bar.dart';
import 'package:google_translate_clone/features/home/presentation/views/widgets/select_language_app_bar.dart';

class SelectLanguageView extends StatefulWidget {
  const SelectLanguageView({super.key, required this.callback});
  final void Function(LanguageModel) callback;

  @override
  State<SelectLanguageView> createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<SelectLanguageView> {
  final TextEditingController _searchController = TextEditingController();
  List<LanguageModel> _languages = [];
  List<LanguageModel> _filteredLanguages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SelectLanguageAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            MySearchBar(
              controller: _searchController,
              onChanged: _filterLanguages,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: FutureBuilder<List<LanguageModel>>(
                future:
                    BlocProvider.of<TranslateCubit>(context).loadLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.language,
                              size: 60,
                              color: Colors.blueAccent.withOpacity(0.7)),
                          const SizedBox(height: 16),
                          const Text(
                            "No languages available",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  if (_languages.isEmpty) {
                    _languages = snapshot.data!;
                    _filteredLanguages = _languages;
                  }
                  return LanguageList(
                    languages: _filteredLanguages,
                    onLanguageTap: (language) {
                      widget.callback(language);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterLanguages(String query) {
    setState(() {
      _filteredLanguages = _languages
          .where((language) =>
              language.name.toLowerCase().contains(query.toLowerCase()) ||
              language.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
