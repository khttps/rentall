import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PriceForm extends StatefulWidget {
  final int? from;
  final int? to;
  final Function(int? from, int? to) onApply;
  const PriceForm({
    this.from,
    this.to,
    required this.onApply,
    Key? key,
  }) : super(key: key);

  @override
  State<PriceForm> createState() => _PriceFormState();
}

class _PriceFormState extends State<PriceForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final _fromController =
      TextEditingController(text: widget.from?.toString());
  late final _toController = TextEditingController(text: widget.to?.toString());

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'from',
                    controller: _fromController,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                    ]),
                    decoration: const InputDecoration(
                      hintText: 'From',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'to',
                    controller: _toController,
                    decoration: const InputDecoration(
                      hintText: 'To',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            FormBuilderField(
              name: 'validator',
              builder: (state) {
                if (state.errorText != null) {
                  return Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
              validator: (_) {
                final to = int.tryParse(_toController.text);
                final from = int.tryParse(_fromController.text);

                if (to != null && from != null && to < from) {
                  return 'Start value can\'t be larger than end value.';
                }
              },
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.from != null || widget.to != null)
                  Flexible(
                    flex: 1,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        widget.onApply(0, 0);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: ElevatedButton(
                    child: const Text('Apply'),
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final values = _formKey.currentState!.value;
                        widget.onApply(
                          int.tryParse(values['from']),
                          int.tryParse(values['to']),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
