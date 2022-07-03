import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Color color;
  final String asset;
  final VoidCallback onPressed;
  const SocialButton({
    required this.text,
    required this.color,
    required this.asset,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(asset, width: 20.0),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: color,
        ),
      ),
    );
  }
}
