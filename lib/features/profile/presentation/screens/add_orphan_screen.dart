import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_date_picker.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';

class AddOrphanScreen extends StatefulWidget {
  const AddOrphanScreen({super.key});

  @override
  State<AddOrphanScreen> createState() => _AddOrphanScreenState();
}

class _AddOrphanScreenState extends State<AddOrphanScreen> {
  final formKey = GlobalKey<FormState>();

  XFile? image;
  String? gender;
  String? religion;
  String? hairColor;
  String? hairStyle;
  String? skinTone;
  String? eyeColor;
  String? personality;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      bloc.addNewOrphan(
        OrphanParams(
          name: nameController.text.trim(),
          birthdate: birthdateController.text,
          gender: gender!,
          religion: religion!,
          hairColor: hairColor!,
          hairStyle: hairStyle!,
          skinTone: skinTone!,
          eyeColor: eyeColor!,
          personality: personality!,
          image: File(image!.path),
        ),
      );
    }
  }

  final bloc = getIt<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is AddNewOrphanSuccess) {
            context.pop();
            context.pop();
            showSnackBar(context, 'Orphan added successfully');
          } else if (state is AddNewOrphanFail) {
            context.pop();
            showSnackBar(context, state.message);
          } else if (state is AddNewOrphanLoading) {
            showLoading(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Add a New Orphan',
                style: context.textTheme.titleLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: FormField<XFile>(
                          validator: (_) =>
                              image == null ? 'Please upload a photo' : null,
                          builder: (field) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final picker = ImagePicker();
                                    final pickedImage = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                        field.didChange(pickedImage);
                                      });
                                    }
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                    ),
                                    width: context.width * .4,
                                    height: context.width * .4,
                                    child: image == null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add, size: 60),
                                              Text(
                                                'Upload Photo',
                                                style: context
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                            ],
                                          )
                                        : Image.file(
                                            File(image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                if (field.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      field.errorText!,
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      Text('Full name', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      CustomTextField(
                        hint: '',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      Text('Birthdate', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      CustomTextField(
                        controller: birthdateController,
                        hint: '',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Birthdate is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          final birthdate = await showCustomDatePicker(
                            context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(
                              Duration(days: 365 * 200),
                            ),
                            lastDate: DateTime.now(),
                          );
                          if (birthdate != null) {
                            birthdateController.text = DateFormat(
                              'yyyy-MM-dd',
                            ).format(birthdate);
                            setState(() {});
                          }
                        },
                      ),
                      SizedBox(height: 16),

                      Text('Gender', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      FormField<String>(
                        validator: (_) =>
                            gender == null ? 'Please select a gender' : null,
                        builder: (field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      gender = 'male';
                                      setState(() {});
                                      field.didChange(gender);
                                    },
                                    child: Chip(
                                      label: Text(
                                        "Male",
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(
                                              color: gender == 'male'
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                      avatar: Icon(
                                        Icons.male,
                                        color: gender == 'male'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      backgroundColor: gender == 'male'
                                          ? AppPalette.primaryColor
                                          : AppPalette.backgroundColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      gender = 'female';
                                      setState(() {});
                                      field.didChange(gender);
                                    },
                                    child: Chip(
                                      label: Text(
                                        "Female",
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(
                                              color: gender == 'female'
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                      avatar: Icon(
                                        Icons.female,
                                        color: gender == 'female'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      backgroundColor: gender == 'female'
                                          ? AppPalette.primaryColor
                                          : AppPalette.backgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (field.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    field.errorText!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 16),

                      Text('Religion', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      FormField<String>(
                        validator: (_) => religion == null
                            ? 'Please select a religion'
                            : null,
                        builder: (field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      religion = 'muslim';
                                      setState(() {});
                                      field.didChange(religion);
                                    },
                                    child: Chip(
                                      label: Text(
                                        "Muslim",
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(
                                              color: religion == 'muslim'
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                      backgroundColor: religion == 'muslim'
                                          ? AppPalette.primaryColor
                                          : AppPalette.backgroundColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      religion = 'christian';
                                      setState(() {});
                                      field.didChange(religion);
                                    },
                                    child: Chip(
                                      label: Text(
                                        "Christian",
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(
                                              color: religion == 'christian'
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                      backgroundColor: religion == 'christian'
                                          ? AppPalette.primaryColor
                                          : AppPalette.backgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (field.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    field.errorText!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hair color',
                        style: context.textTheme.headlineLarge,
                      ),
                      SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppPalette.backgroundColor,
                        value: hairColor,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorStyle: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        hint: Text(
                          'Select hair color',
                          style: context.textTheme.headlineMedium,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select hair color' : null,
                        onChanged: (value) => setState(() => hairColor = value),
                        items: ["Black", "Brown", "Blonde", "Red"]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: context.textTheme.headlineMedium,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 16),

                      Text(
                        'Hair style',
                        style: context.textTheme.headlineLarge,
                      ),
                      SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppPalette.backgroundColor,
                        value: hairStyle,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorStyle: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        hint: Text(
                          'Select hair style',
                          style: context.textTheme.headlineMedium,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select hair style' : null,
                        onChanged: (value) => setState(() => hairStyle = value),
                        items:
                            [
                                  "Curly",
                                  "Straight",
                                  "Wavy",
                                  "Short",
                                  "Long",
                                  "Braided",
                                  "Spiky",
                                  "Pigtails",
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: context.textTheme.headlineMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 16),

                      Text('Eye color', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppPalette.backgroundColor,
                        value: eyeColor,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorStyle: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        hint: Text(
                          'Select eye color',
                          style: context.textTheme.headlineMedium,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select eye color' : null,
                        onChanged: (value) => setState(() => eyeColor = value),
                        items: ["Blue", "Green", "Brown", "Hazel", "Dark"]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: context.textTheme.headlineMedium,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 16),

                      Text('Skin tone', style: context.textTheme.headlineLarge),
                      SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppPalette.backgroundColor,
                        value: skinTone,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorStyle: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        hint: Text(
                          'Select skin tone',
                          style: context.textTheme.headlineMedium,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select skin tone' : null,
                        onChanged: (value) => setState(() => skinTone = value),
                        items: ["Light", "Medium", "Dark", "Pale", "Fair"]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: context.textTheme.headlineMedium,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 16),

                      Text(
                        'Personality',
                        style: context.textTheme.headlineLarge,
                      ),
                      SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppPalette.backgroundColor,
                        value: personality,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorStyle: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        hint: Text(
                          'Select personality',
                          style: context.textTheme.headlineMedium,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select personality' : null,
                        onChanged: (value) =>
                            setState(() => personality = value),
                        items:
                            [
                                  "Shy",
                                  "Cheerful",
                                  "Quiet",
                                  "Calm",
                                  "Playful",
                                  "Curious",
                                  "Friendly",
                                  "Confident",
                                  "Artistic",
                                  "Polite",
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: context.textTheme.headlineMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 32),

                      CustomButton(text: 'Add Orphan', onPressed: submitForm),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
