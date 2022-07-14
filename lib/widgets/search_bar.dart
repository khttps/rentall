import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool enabled;
  final Function(String)? onChanged;
  final bool autofocus;
  const SearchBar({
    this.onChanged,
    this.enabled = false,
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
        hintText: tr('search'),
        enabled: widget.enabled,
        prefixIcon: widget.enabled
            ? InkWell(
                child: const Icon(Icons.arrow_back),
                onTap: () => Navigator.pop(context),
              )
            : const Icon(Icons.search),
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
