import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/screens/auth/bloc/auth_bloc.dart';
import 'widgets.dart';

class AuthForm extends StatefulWidget {
  final String label;
  final List<Widget> actions;
  final Function(Map<String, dynamic>) onSubmit;
  const AuthForm({
    required this.label,
    required this.actions,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'to_rental',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ).tr(args: [widget.label]),
            const SizedBox(height: 8.0),
            const Text(
              'auth_header',
              style: TextStyle(fontSize: 14.0),
            ).tr(),
            const SizedBox(height: 16.0),
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: tr('email'),
              ),
              validator: FormBuilderValidators.required(
                errorText: tr('required'),
              ),
            ),
            const SizedBox(height: 8.0),
            FormBuilderTextField(
              name: 'password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: tr('password'),
              ),
              validator: FormBuilderValidators.required(
                errorText: tr('required'),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    widget.onSubmit(_formKey.currentState!.value);
                  }
                },
              ),
            ),
            const Divider(thickness: 1.0),
            SocialButton(
              text: tr('continue_with', args: ['Google']),
              color: Colors.red,
              asset: 'assets/images/google.svg',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const SignInByGoogle());
              },
            ),
            SocialButton(
              text: tr('continue_with', args: ['Facebook']),
              color: Colors.blue,
              asset: 'assets/images/facebook.svg',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const SignInByFacebook(),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.actions,
            ),
          ],
        ),
      ),
    );
  }
}
