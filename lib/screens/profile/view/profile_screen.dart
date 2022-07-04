import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late XFile? _imageFile = null;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (c, _) => [
          PostAppBar(
            title: 'Edit Profile',
            onSave: () {},
          )
        ],
        body: FormBuilder(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : null,
                    child: InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) => _showBottomSheet(context),
                        );
                      },
                      child: _imageFile == null
                          ? const Icon(
                              Icons.add,
                              size: 48.0,
                            )
                          : null,
                    ),
                  ),
                ),
                Text('Name'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(name: 'name'),
                const SizedBox(height: 10.0),
                Text('Email'),
                const SizedBox(height: 6.0),
                FormBuilderTextField(name: 'email'),
                const SizedBox(height: 16.0),
                Divider(thickness: 1.0),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text('Change Password'),
                    children: [
                      Text('Current Password'),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(name: 'current'),
                      const SizedBox(height: 10.0),
                      Text('New Password'),
                      const SizedBox(height: 6.0),
                      FormBuilderTextField(name: 'new'),
                      const SizedBox(height: 10.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Update Password'),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Divider(thickness: 1.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showBottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "Pick Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                label: const Text("Camera"),
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  _takePhoto(ImageSource.camera);
                },
              ),
              const SizedBox(width: 16.0),
              ElevatedButton.icon(
                label: const Text("Gallery"),
                icon: const Icon(Icons.image),
                onPressed: () {
                  _takePhoto(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _takePhoto(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _imageFile = file;
      });
      Navigator.pop(context);
    }
  }
}
