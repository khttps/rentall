import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool enabled;
  final Function(String)? onChanged;
  final Widget? prefix;
  final bool autofocus;
  const SearchBar({
    this.onChanged,
    this.enabled = false,
    this.prefix,
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        enabled: widget.enabled,
        prefixIcon: widget.prefix ?? const Icon(Icons.search),
        suffixIcon: widget.enabled
            ? IconButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _controller.clear();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                icon: const Icon(Icons.close),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
      ),
    );
  }
}
