import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rentall/screens/home/home.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('language').tr(),
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
                  context.setLocale(locale);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );
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
                  context.setLocale(locale);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );
                }
              },
            ),
            title: const Text('العربية'),
          ),
        ],
      ),
    );
  }
}
