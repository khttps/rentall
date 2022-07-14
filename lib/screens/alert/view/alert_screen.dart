import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/widgets/widgets.dart';
import '../../../data/models/models.dart';
import '../bloc/alert_bloc.dart';

class AlertScreen extends StatefulWidget {
  final Alert? alert;
  static const routeName = '/alert';
  const AlertScreen({
    this.alert,
    Key? key,
  }) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final _controller = TextEditingController();
  late final _keywords = widget.alert?.keywords ?? ['Sample'];
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.alert == null;
    return Scaffold(
      body: BlocConsumer<AlertBloc, AlertState>(
        listener: (context, state) {
          if (state.status == AlertStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackbar(message: state.error!),
            );
          } else if (state.status == AlertStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isNew ? 'alert_added' : 'alert_updated').tr(),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state.status == AlertStatus.deleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('alert_deleted').tr(),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (c, i) => [
                  PostAppBar(
                    title: tr('create_alert'),
                    onSave: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final value = _formKey.currentState!.value;
                        BlocProvider.of<AlertBloc>(context).add(
                          isNew
                              ? AddAlert(
                                  alertMap: value,
                                  keywords: _keywords,
                                )
                              : UpdateAlert(
                                  id: widget.alert!.id!,
                                  alert: value,
                                  keywords: _keywords,
                                ),
                        );
                      }
                    },
                  )
                ],
                body: FormBuilder(
                  key: _formKey,
                  initialValue: isNew
                      ? {}
                      : widget.alert!.toJson().map(
                            (key, value) => (value is int?)
                                ? MapEntry(key, '$value')
                                : MapEntry(key, value),
                          ),
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const Text(
                        'alert_header',
                        style: TextStyle(fontSize: 16.0),
                      ).tr(),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: tr('new_keyword'),
                              ),
                              onChanged: (_) {
                                if (_controller.text.endsWith(' ') &&
                                    _controller.text.trim().isNotEmpty) {
                                  setState(() {
                                    _keywords.add(_controller.text.trim());
                                    _controller.clear();
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_controller.text.trim().isNotEmpty) {
                                setState(() {
                                  _keywords.add(_controller.text.trim());
                                  _controller.clear();
                                });
                              }
                            },
                            child: const Text('add').tr(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text('keywords').tr(),
                      const SizedBox(height: 4.0),
                      Wrap(
                        spacing: 4.0,
                        children: _keywords.asMap().entries.map(
                          (e) {
                            return Chip(
                              label: Text(e.value),
                              onDeleted: () => setState(() {
                                _keywords.removeAt(e.key);
                              }),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 4.0),
                      const SizedBox(height: 6.0),
                      CustomValidator(
                        validator: (_) {
                          if (_keywords.isEmpty) {
                            return tr('keywords_required');
                          }
                          if (_keywords.length > 15) {
                            return tr('max15');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      if (widget.alert != null) ...[
                        const Spacer(),
                        Center(
                          child: TextButton.icon(
                            label: const Text('delete').tr(),
                            icon: const Icon(Icons.delete),
                            style: TextButton.styleFrom(primary: Colors.red),
                            onPressed: () => _showAlertDialog(
                              context,
                              title: const Text('delete_alert').tr(),
                              content: const Text(
                                'delete_alert_content',
                              ),
                              onPositive: () {
                                BlocProvider.of<AlertBloc>(context).add(
                                  DeleteAlert(id: widget.alert!.id!),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              ),
              if (state.status == AlertStatus.loading) const LoadingWidget(),
            ],
          );
        },
      ),
    );
  }

  Future _showAlertDialog(
    BuildContext context, {
    Widget? title,
    Widget? content,
    required Function() onPositive,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        content: content,
        onPositive: onPositive,
      ),
    );
  }
}
