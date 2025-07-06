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

// ? GET ORPHANGES
final class GetAllKidsLoading extends OrphangesState {}

final class GetAllKidsError extends OrphangesState {
  final String message;
  const GetAllKidsError({required this.message});
}

final class GetAllKidsLoaded extends OrphangesState {
  final List<ChildModel> children;
  const GetAllKidsLoaded({required this.children});
}
