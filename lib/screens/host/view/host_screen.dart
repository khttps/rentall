import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:phone_number/phone_number.dart';

import '../../../widgets/widgets.dart';
import '../../blocs.dart';
import '../../screens.dart';

class HostScreen extends StatefulWidget {
  static const routeName = '/host';
  const HostScreen({Key? key}) : super(key: key);

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _image;
  bool _validPhone = false;
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HostBloc>(context).add(const LoadHost());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          PostAppBar(
            title: tr('host'),
            onSave: () async {
              _validPhone =
                  await PhoneNumberUtil().validate(_phoneController.text, 'EG');

              if (_formKey.currentState!.saveAndValidate()) {
                BlocProvider.of<HostBloc>(context).add(
                  SetupHost(
                    host: _formKey.currentState!.value,
                    image: _image,
                  ),
                );
              }
            },
          )
        ],
        body: BlocConsumer<HostBloc, HostState>(
          listener: (context, state) {
            if (state.status == HostStatus.saved) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('host_updated').tr(),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state.status == HostStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(message: state.message!),
              );
            }
          },
          builder: (context, state) {
            if (state.status == HostStatus.loaded) {
              _nameController.text = state.user!.hostName ?? '';
              _phoneController.text = state.user!.hostPhone ?? '';
            }
            return Stack(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const SizedBox(height: 20.0),
                      ImageCircleAvatar(
                        radius: 62.0,
                        initialImage: state.user?.hostAvatar,
                        onAdded: (image) {
                          if (image != null) {
                            _image = image;
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'host_header',
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ).tr(),
                      const SizedBox(height: 20.0),
                      const Text('h/o').tr(),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(
                        name: 'hostName',
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16.0),
                      const Text('phone_number').tr(),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(
                        name: 'hostPhone',
                        controller: _phoneController,
                        decoration:
                            const InputDecoration(prefix: Text('+20  ')),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: tr('required'),
                          ),
                          FormBuilderValidators.numeric(),
                          (_) {
                            if (!_validPhone) {
                              return tr('invalid_phone');
                            }
                            return null;
                          }
                        ]),
                      ),
                    ],
                  ),
                ),
                if (state.status == HostStatus.saving ||
                    state.status == HostStatus.loading)
                  const LoadingWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
