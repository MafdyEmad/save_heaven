import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/data_source/orphanage_donation_remote_data_source.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/adoption_requests.dart';

part 'orphanage_donation_state_state.dart';

class OrphanageDonationCubit extends Cubit<OrphanageDonationStateState> {
  final OrphanageDonationRemoteDataSource _orphanageDonationRemoteDataSource;
  OrphanageDonationCubit(this._orphanageDonationRemoteDataSource) : super(OrphanageDonationStateInitial());

  void getRequests() async {
    emit(GetDonationsRequestsLoading());
    final result = await _orphanageDonationRemoteDataSource.getAdoptionRequests();
    result.fold(
      (error) => emit(GetDonationsRequestsFail(message: error.message)),
      (requests) => emit(GetDonationsRequestsSuccess(requests: requests)),
    );
  }

  void getDonationItems() async {
    emit(GetDonationsLoading());
    final result = await _orphanageDonationRemoteDataSource.getDonations();
    result.fold(
      (error) => emit(GetDonationsFail(message: error.message)),
      (requests) => emit(GetDonationsSuccess()),
    );
  }

  void respondToRequest(String requestId, String response) async {
    emit(RespondToRequestLoading());
    final result = await _orphanageDonationRemoteDataSource.respondToRequest(requestId, response);
    result.fold(
      (error) => emit(RespondToRequestFail(message: error.message)),
      (_) => emit(RespondToRequestSuccess()),
    );
  }
}
