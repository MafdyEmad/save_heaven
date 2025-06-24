part of 'orphanage_donation_state_cubit.dart';

sealed class OrphanageDonationStateState extends Equatable {
  const OrphanageDonationStateState();

  @override
  List<Object> get props => [];
}

final class OrphanageDonationStateInitial extends OrphanageDonationStateState {}

//? get requests
final class GetDonationsRequestsLoading extends OrphanageDonationStateState {}

final class GetDonationsRequestsSuccess extends OrphanageDonationStateState {
  final List<AdoptionRequestsModel> requests;

  const GetDonationsRequestsSuccess({required this.requests});
}

final class GetDonationsRequestsFail extends OrphanageDonationStateState {
  final String message;

  const GetDonationsRequestsFail({required this.message});
}

//? resend to request
final class RespondToRequestLoading extends OrphanageDonationStateState {}

final class RespondToRequestSuccess extends OrphanageDonationStateState {}

final class RespondToRequestFail extends OrphanageDonationStateState {
  final String message;

  const RespondToRequestFail({required this.message});
}
