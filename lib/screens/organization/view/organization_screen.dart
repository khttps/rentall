import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/widgets/post_app_bar.dart';
import 'package:rentall/widgets/widgets.dart';

class OrganizationScreen extends StatefulWidget {
  static const routeName = '/organization';
  const OrganizationScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          PostAppBar(
            title: 'Organization',
            onSave: () {},
          )
        ],
        body: SafeArea(
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const ImageCircleAvatar(
                  radius: 62.0,
                  icon: Icons.add,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Setup your host profile, to be able to post your rentals and allow users to reach you',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                const Text('Organization Name'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'name',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                const Text('Phone Number'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(
                  name: 'hostPhone',
                  decoration: const InputDecoration(prefix: Text('+20  ')),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
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
        ),
      ),
    );
  }
}
