import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/title_widget.dart';
import 'package:save_heaven/features/kids/presentation/cubit/Filter%20cubit/filter_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/Filter%20cubit/filter_state.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/chips_row_widget.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/custom_dropdown_widget.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/filter_chip_widget.dart';

class FilterBody extends StatelessWidget {
  const FilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final itemHeight = height * 0.055;

    final cubit = context.read<FilterCubit>();

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.black,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                color: AppColors.yellow,
                width: double.infinity,
              ),
              const SizedBox(height: 24),

              buildTitle("Gender"),
              buildChipsRow([
                FilterChipWidget(
                  label: "Male",
                  selected: state.gender,
                  onTap: cubit.selectGender,
                ),
                FilterChipWidget(
                  label: "Female",
                  selected: state.gender,
                  onTap: cubit.selectGender,
                ),
              ]),

              const SizedBox(height: 16),
              buildTitle("Age"),
              buildChipsRow([
                FilterChipWidget(
                  label: "0-3",
                  selected: state.ageGroup,
                  onTap: cubit.selectAgeGroup,
                ),
                FilterChipWidget(
                  label: "4-6",
                  selected: state.ageGroup,
                  onTap: cubit.selectAgeGroup,
                ),
                FilterChipWidget(
                  label: "7-12",
                  selected: state.ageGroup,
                  onTap: cubit.selectAgeGroup,
                ),
                FilterChipWidget(
                  label: "+13",
                  selected: state.ageGroup,
                  onTap: cubit.selectAgeGroup,
                ),
              ]),

              const SizedBox(height: 16),
              buildTitle("Educational Level"),
              CustomDropdownWidget(
                hint: "Select Level",
                selected: state.level,
                onChanged: cubit.selectLevel,
                options: const ["Primary", "Middle", "High School", "College"],
              ),

              buildTitle("Orphanage"),
              CustomDropdownWidget(
                hint: "Select Orphanage",
                selected: state.orphanage,
                onChanged: cubit.selectOrphanage,
                options: const ["Bethany", "SOS", "Dar Al Orman"],
              ),

              buildTitle("Religion"),
              buildChipsRow([
                FilterChipWidget(
                  label: "Muslim",
                  selected: state.religion,
                  onTap: cubit.selectReligion,
                ),
                FilterChipWidget(
                  label: "Christian",
                  selected: state.religion,
                  onTap: cubit.selectReligion,
                ),
              ]),

              const SizedBox(height: 16),
              buildTitle("Skin Tone"),
              CustomDropdownWidget(
                hint: "Select Tone",
                selected: state.skinTone,
                onChanged: cubit.selectSkinTone,
                options: const ["Light", "Medium", "Dark"],
              ),

              buildTitle("Hair Type"),
              buildChipsRow([
                FilterChipWidget(
                  label: "Curly",
                  selected: state.hairType,
                  onTap: cubit.selectHairType,
                ),
                FilterChipWidget(
                  label: "Wavy",
                  selected: state.hairType,
                  onTap: cubit.selectHairType,
                ),
                FilterChipWidget(
                  label: "Straight",
                  selected: state.hairType,
                  onTap: cubit.selectHairType,
                ),
              ]),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Reset All",
                      onPressed: cubit.resetAll,
                      borderRadius: 12,
                      height: itemHeight,
                      fontSize: 14,
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.babyBlue,
                      textColor: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: "Search",
                      onPressed: () {
                        print(
                          "Filters: ${state.gender}, ${state.ageGroup}, ${state.level}",
                        );
                      },
                      borderRadius: 12,
                      height: itemHeight,
                      fontSize: 14,
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
