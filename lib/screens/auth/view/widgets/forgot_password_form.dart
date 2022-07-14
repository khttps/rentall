import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../screens.dart';

class ForgotPasswordForm extends StatefulWidget {
  final Function(String?) onSubmit;
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'enter_email',
              style: TextStyle(fontSize: 16.0),
            ).tr(),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) {},
              onChanged: (String value) {},
              decoration: InputDecoration(
                hintText: tr('email'),
              ),
              validator: FormBuilderValidators.required(
                errorText: tr('required'),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text(
                  'submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ).tr(),
                onPressed: () {
                  widget.onSubmit(_controller.text);
                  _controller.clear();
                },
              ),
            ),
            TextButton(
              onPressed: () {
                widget.onSubmit(null);
                _controller.clear();
              },
              child: const Text(
                'sign_in',
                style: TextStyle(decoration: TextDecoration.underline),
              ).tr(),
            )
          ],
        ),
      ),
    );
  }
}
