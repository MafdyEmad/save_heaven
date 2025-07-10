import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/ai_search/presentaion/cubit/ai_cubit.dart';

class AiSearchScreen extends StatefulWidget {
  const AiSearchScreen({super.key});

  @override
  State<AiSearchScreen> createState() => _AiSearchScreenState();
}

class _AiSearchScreenState extends State<AiSearchScreen> {
  final bloc = getIt<AiCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('AI Search', style: context.textTheme.titleLarge),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),

              child: Column(
                children: [
                  CustomTextField(hint: 'search for a kid', maxLines: 4),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      bloc.aiSearch('I awnt a kidd wth red hair');
                    },
                    child: Text(
                      'Search',
                      style: context.textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
