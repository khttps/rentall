import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../widgets/widgets.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const routeName = '/update_password';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (c, _) => [
          PostAppBar(
            title: 'Update Password',
            onSave: () {},
          )
        ],
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Password'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'current',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                const Text('New Password'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'new',
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
