import 'package:flutter/material.dart';

class SelectLanguageSearchBar extends StatelessWidget {
  const SelectLanguageSearchBar(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search Languages...',
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onChanged: onChanged,
    );
  }
}
