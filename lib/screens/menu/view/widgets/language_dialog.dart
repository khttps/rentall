import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../home/home.dart';

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
              onChanged: (locale) async {
                if (locale != null) {
                  await _changeLocaleAndRestart(
                    context,
                    locale: locale,
                    onDone: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    },
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
              onChanged: (locale) async {
                if (locale != null) {
                  await _changeLocaleAndRestart(
                    context,
                    locale: locale,
                    onDone: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    },
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

  Future<void> _changeLocaleAndRestart(
    BuildContext context, {
    required Locale locale,
    required VoidCallback onDone,
  }) async {
    await context.setLocale(locale);
    onDone();
  }
}
