import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../widgets/widgets.dart';
import '../../blocs.dart';
import '../../screens.dart';

class HostScreen extends StatefulWidget {
  static const routeName = '/organization';
  const HostScreen({Key? key}) : super(key: key);

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          PostAppBar(
            title: 'Host',
            onSave: () {
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
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Host updated successfully!'),
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
                        icon: Icons.add,
                        onAdded: (image) {
                          if (image != null) {
                            _image = File(image.path);
                          }
                        },
                        initialImage: state.user?.hostAvatar,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Setup your host profile, to be able to post your rentals and allow users to reach you',
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      const Text('Host/Organization'),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(
                        name: 'hostName',
                        initialValue: state.user?.hostName,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16.0),
                      const Text('Phone Number'),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(
                        name: 'hostPhone',
                        initialValue: state.user?.hostPhone,
                        decoration:
                            const InputDecoration(prefix: Text('+20  ')),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: tr('required'),
                          ),
                          FormBuilderValidators.numeric(),
                        ]),
                      ),
                    ],
                  ),
                ),
                if (state.status == HostStatus.saving) const LoadingWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
