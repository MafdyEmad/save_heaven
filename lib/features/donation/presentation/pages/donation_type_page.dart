import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/donation_type_body.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';

class DonationTypePage extends StatelessWidget {
  final String orphanageId;
  const DonationTypePage({super.key, required this.orphanageId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Donation', style: context.textTheme.titleLarge),
            ),
            backgroundColor: Colors.white,
            body: DonationTypeBody(
              width: width,
              height: height,
              orphanageId: orphanageId,
            ),
          );
        },
      ),
    );
  }
}
