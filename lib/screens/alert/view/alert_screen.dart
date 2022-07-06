import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rentall/widgets/post_app_bar.dart';

class AlertScreen extends StatefulWidget {
  static const routeName = '/alert';
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          PostAppBar(
            title: 'Create Alert',
            onSave: () {},
          )
        ],
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Row(
              children: [
                const Text('Repeat every'),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 50.0,
                  child: FormBuilderTextField(
                    name: 'repeat',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text('day'),
              ],
            ),
            Wrap(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
