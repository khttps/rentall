import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/widgets/post_app_bar.dart';

import '../../../widgets/custom_validator.dart';

class AlertScreen extends StatefulWidget {
  static const routeName = '/alert';
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final _controller = TextEditingController();
  final _keywords = ['Sample'];
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          PostAppBar(
            title: 'Create Alert',
            onSave: () {
              if (_formKey.currentState!.saveAndValidate()) {}
            },
          )
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Setup alerts to stay up-to-date and discover rentals matching your preference',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                const Text('Keywords'),
                const SizedBox(height: 4.0),
                Wrap(
                    spacing: 4.0,
                    children: _keywords
                        .asMap()
                        .entries
                        .map(
                          (e) => Chip(
                            label: Text(e.value),
                            onDeleted: () {
                              setState(() {
                                _keywords.removeAt(e.key);
                              });
                            },
                          ),
                        )
                        .toList()),
                const SizedBox(height: 4.0),
                TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    if (value.endsWith(' ') && value.trim().isNotEmpty) {
                      _addKeyword();
                    }
                  },
                  minLines: 3,
                  maxLines: 3,
                ),
                const SizedBox(height: 6.0),
                CustomValidator(
                  validator: (_) {
                    if (_keywords.isEmpty) {
                      return 'Keywords can\'t be empty';
                    }
                    if (_keywords.length > 15) {
                      return 'Maximum number of keywords is 15';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ElevatedButton(
                    onPressed: () {
                      _addKeyword();
                    },
                    child: const Text('Add'),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Repeat every'),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      width: 100.0,
                      child: FormBuilderTextField(
                        name: 'repeat',
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Required'),
                          FormBuilderValidators.notEqual(0),
                          FormBuilderValidators.max(14),
                        ]),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text('day'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addKeyword() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _keywords.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }
}
