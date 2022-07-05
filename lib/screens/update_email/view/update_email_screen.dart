import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/screens/home/home.dart';
import 'package:rentall/screens/update_email/bloc/update_email_bloc.dart';

import '../../../widgets/widgets.dart';

class UpdateEmailScreen extends StatefulWidget {
  final User? user;
  static const routeName = '/update_email';
  const UpdateEmailScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          PostAppBar(
            title: 'Update Email',
            onSave: () {
              if (_formKey.currentState!.saveAndValidate()) {
                final value = _formKey.currentState!.value;
                BlocProvider.of<UpdateEmailBloc>(context).add(
                  SavePressed(
                    newEmail: value['email'],
                    currentPassword: value['password'],
                  ),
                );
              }
            },
          )
        ],
        body: BlocConsumer<UpdateEmailBloc, UpdateEmailState>(
          listener: (context, state) {
            if (state.status == UpdateEmailStatus.failed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(ErrorSnackbar(message: state.message!));
            }
            if (state.status == UpdateEmailStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email changed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email Address'),
                        const SizedBox(height: 6.0),
                        FormBuilderTextField(
                          name: 'email',
                          initialValue: widget.user?.email ?? '',
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Current Password'),
                        const SizedBox(height: 6.0),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          validator: FormBuilderValidators.required(),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.status == UpdateEmailStatus.loading)
                  const LoadingWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
