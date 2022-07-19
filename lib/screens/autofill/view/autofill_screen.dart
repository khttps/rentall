import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import '../../../widgets/search_bar.dart';

class AutofillScreen extends StatefulWidget {
  static const routeName = '/autofill';
  const AutofillScreen({Key? key}) : super(key: key);

  @override
  State<AutofillScreen> createState() => _AutofillScreenState();
}

class _AutofillScreenState extends State<AutofillScreen> {
  static const _apiKey = 'AIzaSyBhx6ri_9UQuGXNQDeSsalYau0YIuk0XNo';
  final _places = GooglePlace(_apiKey);

  var _predictions = <AutocompletePrediction>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: SearchBar(
          enabled: true,
          autofocus: true,
          onChanged: (value) {
            if (value.trim().isNotEmpty) {
              _autoCompleteSearch(value);
            }
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: _predictions.length,
        shrinkWrap: true,
        separatorBuilder: (c, i) => const Divider(thickness: 1.0, height: 1.0),
        itemBuilder: (context, index) {
          final title = _predictions[index].structuredFormatting?.mainText;
          final subtitle =
              _predictions[index].structuredFormatting?.secondaryText;
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              subtitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).pop(
                _predictions[index].structuredFormatting,
              );
            },
          );
        },
      ),
    );
  }

  void _autoCompleteSearch(String query) async {
    final result = await _places.autocomplete.get(
      query,
      components: [Component("country", "eg")],
    );

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        _predictions = result.predictions ?? [];
      });
    }
  }
}
