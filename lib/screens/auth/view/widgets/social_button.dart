import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          asset,
          width: 20.0,
          height: 20.0,
        ),
        label: Text(text),
        style: OutlinedButton.styleFrom(
            primary: color, side: BorderSide(color: color)
            // backgroundColor: color,
            ),
      ),
    );
  }
}
