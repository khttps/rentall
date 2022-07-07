import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool? enabled;
  final Function(String)? onChanged;
  const SearchBar({
    this.onChanged,
    this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      autofocus: widget.enabled ?? true,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        enabled: widget.enabled ?? true,
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
      ),
    );
  }
}
