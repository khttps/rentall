import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/screens/auth/auth.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../widgets/widgets.dart';
import '../../home/view/home_screen.dart';
import '../bloc/update_password_bloc.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const routeName = '/update_password';
  final User user;
  const UpdatePasswordScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (c, _) => [
          PostAppBar(
            title: tr('update_password'),
            onSave: () {
              if (_formKey.currentState!.saveAndValidate()) {
                final value = _formKey.currentState!.value;
                BlocProvider.of<UpdatePasswordBloc>(context).add(
                  SavePasswordPressed(
                    currentPassword:
                        value.containsKey('current') ? value['current'] : null,
                    newPassword: value['new'],
                  ),
                );
              }
            },
          )
        ],
        body: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
          listener: (context, state) {
            if (state.status == UpdatePasswordStatus.failed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(ErrorSnackbar(message: state.message!));
            } else if (state.status == UpdatePasswordStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('password_changed').tr(),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
            } else if (state.status == UpdatePasswordStatus.requiresLogin) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(message: state.message!),
              );
              Navigator.pushNamed(
                context,
                AuthScreen.routeName,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.user.providerData.any((p) {
                          return p.providerId == 'password';
                        })) ...[
                          const Text('current_password').tr(),
                          const SizedBox(height: 6.0),
                          FormBuilderTextField(
                            name: 'current',
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.min(8)
                            ]),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                        const Text('new_password').tr(),
                        const SizedBox(height: 6.0),
                        FormBuilderTextField(
                          name: 'new',
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.min(8)
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.status == UpdatePasswordStatus.loading)
                  const LoadingWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
