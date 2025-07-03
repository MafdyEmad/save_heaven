import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/auth/data/models/user_model.dart';
import 'package:save_heaven/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:save_heaven/features/profile/data/models/porfile_model.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  final UserDataResponse user;
  final String userId;
  const EditProfileScreen({
    super.key,
    required this.userId,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    if (widget.user.about.workHours.isNotEmpty) {
      selectedDays.addAll(widget.user.about.workDays);
    }
    if (widget.user.about.workHours.isNotEmpty) {
      fromTime = _parseTimeOfDay(widget.user.about.workHours.first);

      toTime = _parseTimeOfDay(widget.user.about.workHours.last);
    }
    name.text = widget.user.user.name;
    location.text = widget.user.user.address;
    email.text = widget.user.user.email;
    setState(() {});
    super.initState();
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final dateTime = DateFormat.jm().parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  final bloc = getIt<ProfileCubit>();
  File? image;

  List<String> selectedDays = [];
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  final List<String> allDaysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController location = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    location.dispose();
    super.dispose();
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    setState(() {});
  }

  void setFromTime(TimeOfDay time) {
    fromTime = time;
    setState(() {});
  }

  void setToTime(TimeOfDay time) {
    toTime = time;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is UpdateUserLoading) {
                showLoading(context);
              } else if (state is UpdateUserSuccess) {
                context.pop();
                context.pop();
                bloc.getUser();
              } else if (state is UpdateUserFail) {
                context.pop();
                showCustomDialog(
                  context,
                  title: 'Error while updating profile',
                  content: state.message,
                  confirmText: 'Close',
                  cancelText: '',
                  onConfirm: () => context.pop(),
                  onCancel: null,
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Edit Profile',
                  style: context.textTheme.titleLarge,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  width: context.width * .4,
                                  height: context.width * .4,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: image != null
                                      ? Image.file(image!, fit: BoxFit.cover)
                                      : CachedNetworkImage(
                                          imageUrl: '',
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.person, size: 50),
                                        ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        if (image != null) {
                                          image = null;
                                          setState(() {});
                                          return;
                                        }
                                        final picker = ImagePicker();
                                        final pickedFile = await picker
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );
                                        if (pickedFile != null) {
                                          setState(() {
                                            image = File(pickedFile.path);
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        image != null
                                            ? Icons.close
                                            : Icons.edit,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Name', style: context.textTheme.headlineLarge),
                          SizedBox(height: 2),
                          CustomTextField(
                            hint: '',
                            controller: name,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Text('Email', style: context.textTheme.headlineLarge),
                          // SizedBox(height: 2),
                          // CustomTextField(
                          //   hint: '',
                          //   controller: email,
                          //   validator: (p0) {
                          //     if (p0!.isEmpty) {
                          //       return 'Email is required';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(height: 20),
                          Text(
                            'Location',
                            style: context.textTheme.headlineLarge,
                          ),
                          SizedBox(height: 2),
                          CustomTextField(
                            hint: '',
                            controller: location,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Location is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Select working days',
                            style: context.textTheme.headlineLarge,
                          ),
                          SizedBox(height: 2),
                          FormField(
                            validator: (value) {
                              if (selectedDays.isEmpty) {
                                return 'Please select at least one day';
                              }
                              return null;
                            },
                            builder: (field) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: allDaysOfWeek.map((day) {
                                    final selected = selectedDays.contains(day);
                                    return ChoiceChip(
                                      backgroundColor: AppPalette.primaryColor
                                          .withAlpha(150),
                                      selectedColor: AppPalette.primaryColor,
                                      label: Text(
                                        day,
                                        style: context.textTheme.headlineMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      selected: selected,
                                      onSelected: (_) => toggleDay(day),
                                    );
                                  }).toList(),
                                ),
                                if (field.hasError)
                                  Text(
                                    field.errorText!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Select Time From - To:",
                            style: context.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 12),
                          FormField(
                            validator: (value) {
                              if (fromTime == null || toTime == null) {
                                return 'From and To time are required';
                              }
                              return null;
                            },
                            builder: (field) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "From: ",
                                      style: context.textTheme.headlineLarge,
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final picked = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (picked != null) {
                                          if (toTime != null) {
                                            if (picked.hour > toTime!.hour ||
                                                (picked.hour == toTime!.hour &&
                                                    picked.minute >=
                                                        toTime!.minute)) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "From time must be before To time",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                          }
                                          setFromTime(picked);
                                        }
                                      },
                                      child: Text(
                                        fromTime?.format(context) ?? "Select",
                                        style: context.textTheme.headlineLarge
                                            ?.copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Text(
                                      "To: ",
                                      style: context.textTheme.headlineLarge,
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final picked = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (picked != null) {
                                          if (fromTime != null) {
                                            if (picked.hour < fromTime!.hour ||
                                                (picked.hour ==
                                                        fromTime!.hour &&
                                                    picked.minute <
                                                        fromTime!.minute)) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "You can't choose To time before From time",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                          }

                                          setToTime(picked);
                                        }
                                      },
                                      child: Text(
                                        toTime?.format(context) ?? "Select",
                                        style: context.textTheme.headlineLarge
                                            ?.copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (field.hasError)
                                  Text(
                                    field.errorText!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                bloc.updateUser(
                                  ProfileUpdateparams(
                                    image: image,
                                    name: name.text.trim(),
                                    workSchedule: WorkSchedule(
                                      workDays: selectedDays,
                                      workHours: [
                                        fromTime!.format(context),
                                        toTime!.format(context),
                                      ],
                                    ),
                                    email: email.text.trim(),
                                    address: location.text.trim(),
                                  ),
                                );
                              },
                              child: Text(
                                'Save changes',
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
