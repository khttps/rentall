import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../screens.dart';

class ForgotPasswordForm extends StatefulWidget {
  final Function() onSubmit;
  const ForgotPasswordForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Enter the email associated with your account',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (String value) {},
            onChanged: (String value) {},
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required field.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                // TODO
                _controller.clear();
                widget.onSubmit();
                Navigator.pushNamed(context, PasswordSentScreen.routeName,
                    arguments: 'example@example.com');
              },
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.clear();
              widget.onSubmit();
            },
            child: const Text(
              'Sign In',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
