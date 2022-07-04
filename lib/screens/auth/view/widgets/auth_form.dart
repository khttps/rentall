import 'package:flutter/material.dart';
import 'widgets.dart';

class AuthForm extends StatefulWidget {
  final String label;
  final List<Widget> actions;
  const AuthForm({
    required this.label,
    required this.actions,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.label} to Rentall',
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Join our community, post your rentals, setup alerts for new rentals, save your favorite rentals',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
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
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {}
                },
              ),
            ),
            const Divider(thickness: 1.0),
            SocialButton(
              text: '${widget.label} with Google',
              color: Colors.red,
              asset: 'assets/images/google.png',
              onPressed: () {},
            ),
            SocialButton(
              text: '${widget.label} with Facebook',
              color: Colors.blue,
              asset: 'assets/images/facebook.png',
              onPressed: () {},
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
