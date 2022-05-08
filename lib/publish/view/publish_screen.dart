import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:rentall/data/model/governorate.dart';
import 'package:rentall/widgets/widgets.dart';

import '../../data/model/property_type.dart';
import '../../data/model/rental.dart';
import '../../screens.dart';
import '../bloc/publish_bloc.dart';

class PublishScreen extends StatefulWidget {
  static const routeName = '/publish_screen';

  final Rental? rental;
  const PublishScreen({
    this.rental,
    Key? key,
  }) : super(key: key);

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormBuilderState>();

  late final updating = widget.rental != null;
  late final _images = <dynamic>[...?widget.rental?.images];
  late final _phoneController = TextEditingController(
    text: widget.rental?.hostPhoneNumber,
  );

  var _currentPage = 0;
  bool _validPhone = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: NestedScrollView(
          headerSliverBuilder: (c, i) => const [
            SliverAppBar(
              snap: true,
              floating: true,
              forceElevated: true,
              title: Text('New Rental'),
            ),
          ],
          body: BlocConsumer<PublishBloc, PublishState>(
            listener: (context, state) {
              if (state.status == PublishLoadStatus.failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackbar(message: state.error!),
                );
              } else if (state.status == PublishLoadStatus.published) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Rental was successfully ${updating ? 'updated' : 'published'}.'),
                    backgroundColor: const Color.fromARGB(255, 47, 169, 110),
                  ),
                );
                Navigator.popUntil(
                  context,
                  (route) => route.settings.name == HomeScreen.routeName,
                );
                Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: state.rental!,
                );
              } else if (state.status == PublishLoadStatus.deleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rental was successfully deleted.'),
                    backgroundColor: Color.fromARGB(255, 47, 169, 110),
                  ),
                );
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: 1 + _images.length,
                          itemBuilder: (context, index, _) {
                            if (index == _images.length) {
                              return Center(
                                child: FloatingActionButton(
                                  heroTag: 'add_photo',
                                  child: const Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                ),
                              );
                            } else {
                              return Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      child: (_images[index] is String)
                                          ? CachedNetworkImage(
                                              imageUrl: _images[index],
                                              fit: BoxFit.cover,
                                            )
                                          : ImageBuilder(
                                              path: _images[index].path,
                                              aspectRatio: 16 / 9,
                                            ),
                                    ),
                                  ),
                                  if (index == _currentPage)
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: () async {
                                          await _showAlertDialog(
                                            context,
                                            title: const Text(
                                              'Remove this image?',
                                            ),
                                            onPositive: () {
                                              setState(() {
                                                _images.removeAt(index);
                                              });
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0.0, 1.0),
                                                    blurRadius: 1.0)
                                              ]),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.blueGrey,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            aspectRatio: 16 / 9,
                            onPageChanged: (i, _) => setState(
                              () => _currentPage = i,
                            ),
                          ),
                        ),
                      ),
                      FormBuilder(
                        key: _formKey,
                        initialValue: updating
                            ? widget.rental!.toJson().map((key, value) =>
                                (value is int?)
                                    ? MapEntry(key, '$value')
                                    : MapEntry(key, value))
                            : {},
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          children: [
                            FormBuilderField(
                              name: 'imgv',
                              builder: (state) {
                                if (state.errorText != null) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 17.0,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        state.errorText ?? '',
                                        style: const TextStyle(
                                            fontSize: 13.0, color: Colors.red),
                                      )
                                    ],
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              validator: (_) {
                                if (_images.length < 3) {
                                  return 'Please add at least 3 images of your rental.';
                                }
                                if (_images.length > 10) {
                                  return 'Maximum number of images is 10';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8.0),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Text('Title'),
                            ),
                            FormBuilderTextField(
                              name: 'title',
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: tr('required')),
                              ]),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Text('Property Type'),
                            ),
                            FormBuilderDropdown(
                              name: 'propertyType',
                              initialValue: updating
                                  ? widget.rental!.propertyType ??
                                      PropertyType.apartment
                                  : PropertyType.apartment,
                              valueTransformer: (PropertyType? value) {
                                if (value != null) {
                                  return value.name;
                                }
                              },
                              items: List.generate(
                                PropertyType.values.length - 1,
                                (index) => DropdownMenuItem(
                                  value: PropertyType.values[index + 1],
                                  child: Text(
                                    'propertyType.${index + 1}',
                                  ).tr(),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: tr('required')),
                              ]),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Text('Address'),
                            ),
                            FormBuilderTextField(
                              name: 'address',
                              minLines: 3,
                              maxLines: 3,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: tr('required')),
                              ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(child: Text('Governorate')),
                                  SizedBox(width: 8.0),
                                  Expanded(child: Text('Region')),
                                  SizedBox(width: 8.0),
                                  Expanded(child: Text('Period'))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: FormBuilderDropdown(
                                    name: 'governorateId',
                                    initialValue: updating
                                        ? widget.rental!.governorate
                                        : Governorate.cairo,
                                    valueTransformer: (Governorate? value) {
                                      if (value != null) {
                                        return value.name;
                                      }
                                    },
                                    items: List.generate(
                                      27,
                                      (index) => DropdownMenuItem(
                                        value: Governorate.values[index + 1],
                                        child: Text(
                                          'governorates.${index + 1}',
                                          overflow: TextOverflow.ellipsis,
                                        ).tr(),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context,
                                          errorText: tr('required')),
                                    ]),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: FormBuilderTextField(
                                    readOnly: true,
                                    name: 'regionId',
                                    enabled: false,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: FormBuilderDropdown(
                                    name: 'rentType',
                                    initialValue: updating
                                        ? widget.rental!.rentType ??
                                            RentType.daily
                                        : RentType.daily,
                                    valueTransformer: (RentType? value) {
                                      if (value != null) {
                                        return value.name;
                                      }
                                    },
                                    items: List.generate(
                                      RentType.values.length,
                                      (index) => DropdownMenuItem(
                                        value: RentType.values[index],
                                        child: Text(
                                          'rentPeriod.$index',
                                          overflow: TextOverflow.ellipsis,
                                        ).tr(),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context,
                                          errorText: tr('required')),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(child: Text('Area')),
                                  SizedBox(width: 8.0),
                                  Expanded(child: Text('Price')),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: FormBuilderTextField(
                                    name: 'rentPrice',
                                    valueTransformer: (String? value) {
                                      if (value != null) {
                                        return int.tryParse(value);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      suffix: RichText(
                                        text: TextSpan(
                                          text: 'm\u00b3',
                                          style: TextStyle(
                                            color: Colors.black.withAlpha(175),
                                          ),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: tr('required'),
                                      ),
                                      FormBuilderValidators.numeric(context),
                                    ]),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: FormBuilderTextField(
                                    name: 'area',
                                    valueTransformer: (String? value) {
                                      if (value != null) {
                                        return int.tryParse(value);
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      suffix: Text('EGP'),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        context,
                                        errorText: tr('required'),
                                      ),
                                      FormBuilderValidators.numeric(context),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(child: Text('Floor')),
                                  SizedBox(width: 8.0),
                                  Expanded(child: Text('Rooms')),
                                  SizedBox(width: 8.0),
                                  Expanded(child: Text('Bathrooms')),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: FormBuilderTextField(
                                    name: 'floorNumber',
                                    valueTransformer: (String? value) {
                                      if (value != null) {
                                        return int.tryParse(value);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: FormBuilderTextField(
                                    name: 'numberOfRooms',
                                    valueTransformer: (String? value) {
                                      if (value != null) {
                                        return int.tryParse(value);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: FormBuilderTextField(
                                    name: 'numberOfBathrooms',
                                    valueTransformer: (String? value) {
                                      if (value != null) {
                                        return int.tryParse(value);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Text('Phone'),
                            ),
                            FormBuilderTextField(
                              name: 'hostPhoneNumber',
                              controller: _phoneController,
                              decoration:
                                  const InputDecoration(prefix: Text('+20  ')),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  context,
                                  errorText: tr('required'),
                                ),
                                FormBuilderValidators.numeric(context),
                                (_) {
                                  if (!_validPhone) {
                                    return 'Invalid phone number.';
                                  }
                                  return null;
                                }
                              ]),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
                              child: Text('Description'),
                            ),
                            FormBuilderTextField(
                              name: 'description',
                              minLines: 3,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText:
                                    'Write any other details about your rental...',
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (updating)
                                  TextButton.icon(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async =>
                                        await _showAlertDialog(
                                      context,
                                      title: const Text('Delete Rental'),
                                      content: const Text(
                                        'Are you sure you want to delete this rental?',
                                      ),
                                      onPositive: () {
                                        context.read<PublishBloc>().add(
                                              DeleteRental(
                                                id: widget.rental!.id!,
                                              ),
                                            );
                                      },
                                    ),
                                  ),
                                const SizedBox(width: 8.0),
                                ElevatedButton(
                                  child: Text(updating ? 'Update' : 'Publish'),
                                  onPressed: () async {
                                    _validPhone = await PhoneNumberUtil()
                                        .validate(_phoneController.text, 'EG');

                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      context.read<PublishBloc>().add(
                                            widget.rental == null
                                                ? PublishRental(
                                                    rentalMap: _formKey
                                                        .currentState!.value,
                                                    images: _images
                                                        .whereType<XFile>()
                                                        .toList(),
                                                  )
                                                : UpdateRental(
                                                    id: widget.rental!.id!,
                                                    rental: _formKey
                                                        .currentState!.value,
                                                    images: _images
                                                        .whereType<XFile>()
                                                        .toList(),
                                                  ),
                                          );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.status == PublishLoadStatus.loading)
                    const LoadingWidget(),
                ],
              );
            },
          ),
        ),
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
      builder: (context) => AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              onPositive();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          )
        ],
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 180.0,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RawMaterialButton(
              padding: const EdgeInsets.all(20.0),
              onPressed: () async {
                Navigator.pop(context);
                final image = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 50);
                if (image != null) setState(() => _images.add(image));
              },
              elevation: 0.0,
              shape: const CircleBorder(),
              fillColor: Colors.blueGrey,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 50,
              ),
            ),
            RawMaterialButton(
              padding: const EdgeInsets.all(20.0),
              onPressed: () async {
                Navigator.pop(context);
                final images = await _picker.pickMultiImage(imageQuality: 50);
                if (images != null) {
                  setState(() => _images.addAll(images));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    ErrorSnackbar(message: 'Failed to retrieve images.'),
                  );
                }
              },
              elevation: 0.0,
              shape: const CircleBorder(),
              fillColor: Colors.blueGrey,
              child: const Icon(
                Icons.photo,
                color: Colors.white,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
