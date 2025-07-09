// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/kids/presentation/data_source/remote_data_source.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationRemoteDataSource donationRemoteDataSource;
  OrphanageRemoteDataSource orphanageRemoteDataSource;
  DonationCubit(this.donationRemoteDataSource, this.orphanageRemoteDataSource)
    : super(DonationInitial());

  Future<void> donate({
    required bool isMony,
    DonateMony? monyModel,
    DonationItems? itemModel,
  }) async {
    emit(DonationDonateLoading());
    final result = await donationRemoteDataSource.donate(
      isMony: isMony,
      monyModel: monyModel,
      itemModel: itemModel,
    );
    result.fold(
      (error) => emit(DonationDonateFail(message: error.message)),
      (_) => emit(DonationDonateSuccess()),
    );
  }

  Future<void> getOrphanage() async {
    emit(DonationGetOrphanageLoading());
    final result = await orphanageRemoteDataSource.getorphanage();
    result.fold(
      (error) => emit(DonationGetOrphanageFail(message: error.message)),
      (data) => emit(DonationGetOrphanageSuccess(orphanagesResponse: data)),
    );
  }
}
