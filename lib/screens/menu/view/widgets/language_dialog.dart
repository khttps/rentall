import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Radio<Locale>(
              value: const Locale('en'),
              groupValue: context.locale,
              onChanged: (locale) {
                if (locale != null) {
                  Navigator.pop(context);
                  context.setLocale(locale);
                }
              },
            ),
            title: const Text('English'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Radio<Locale>(
              value: const Locale('ar'),
              groupValue: context.locale,
              onChanged: (locale) {
                if (locale != null) {
                  Navigator.pop(context);
                  context.setLocale(locale);
                }
              },
            ),
            title: const Text('Arabic'),
          ),
        ],
      ),
    );
  }
}
