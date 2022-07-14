import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
            Text(
              '${widget.label} to Rentall',
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Join our community, post your rentals, setup alerts for new rentals, save your favorite rentals',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 16.0),
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Email',
                // prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field.';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            FormBuilderTextField(
              name: 'password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field.';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Password'),
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
              text: 'Continue with Google',
              color: Colors.red,
              asset: 'assets/images/google.svg',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const SignInByGoogle());
              },
            ),
            SocialButton(
              text: 'Continue with Facebook',
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
