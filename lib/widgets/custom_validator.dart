import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomValidator extends StatelessWidget {
  final String? Function(Object?) validator;
  const CustomValidator({
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'validator',
      builder: (state) {
        if (state.errorText != null) {
          return Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 17.0,
              ),
              const SizedBox(width: 6.0),
              Text(
                state.errorText ?? '',
                style: const TextStyle(fontSize: 13.0, color: Colors.red),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
      validator: validator,
    );
  }
}
