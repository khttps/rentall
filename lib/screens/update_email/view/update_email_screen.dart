import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../widgets/widgets.dart';

class UpdateEmailScreen extends StatefulWidget {
  static const routeName = '/update_email';
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (c, _) => [
          PostAppBar(
            title: 'Update Email',
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
                const Text('Email Address'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                const Text('Current Password'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'password',
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
