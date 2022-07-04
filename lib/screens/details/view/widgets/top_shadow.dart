import 'package:flutter/material.dart';

class TopShadow extends StatelessWidget {
  const TopShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20.0,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black, offset: Offset(0.0, 1.0), blurRadius: 3.0)
        ],
        color: Colors.white,
      ),
    );
  }
}
