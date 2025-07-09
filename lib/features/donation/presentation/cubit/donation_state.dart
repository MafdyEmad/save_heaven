part of 'donation_cubit.dart';

sealed class DonationState extends Equatable {
  const DonationState();

  @override
  List<Object> get props => [];
}

final class DonationInitial extends DonationState {}

final class DonationDonateLoading extends DonationState {}

final class DonationDonateSuccess extends DonationState {}

final class DonationDonateFail extends DonationState {
  final String message;
  const DonationDonateFail({required this.message});
}

final class DonationGetOrphanageLoading extends DonationState {}

final class DonationGetOrphanageSuccess extends DonationState {
  final OrphanagesResponse orphanagesResponse;

  const DonationGetOrphanageSuccess({required this.orphanagesResponse});
}

final class DonationGetOrphanageFail extends DonationState {
  final String message;
  const DonationGetOrphanageFail({required this.message});
}
