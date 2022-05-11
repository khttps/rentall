import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PriceForm extends StatefulWidget {
  final Function(int? from, int? to) onApply;
  const PriceForm({required this.onApply, Key? key}) : super(key: key);

  @override
  State<PriceForm> createState() => _PriceFormState();
}

class _PriceFormState extends State<PriceForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

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
                      FormBuilderValidators.numeric(context),
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
                      FormBuilderValidators.numeric(context),
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
            ElevatedButton(
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
            )
          ],
        ),
      ),
    );
  }
}