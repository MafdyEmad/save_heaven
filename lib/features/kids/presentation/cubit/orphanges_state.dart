part of 'orphanges_cubit.dart';

sealed class OrphangesState extends Equatable {
  const OrphangesState();

  @override
  List<Object> get props => [];
}

final class OrphangesInitial extends OrphangesState {}

//? GET ORPHANGES
final class OrphangesLoading extends OrphangesState {}

final class OrphangesError extends OrphangesState {
  final String message;
  const OrphangesError({required this.message});
}

final class OrphangesLoaded extends OrphangesState {
  final OrphanagesResponse orphanagesResponse;
  const OrphangesLoaded({required this.orphanagesResponse});
}
