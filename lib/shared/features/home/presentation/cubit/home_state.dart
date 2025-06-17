part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

//? GET POSTS
final class HomeGetPostsSuccess extends HomeState {
  final PostsResponse posts;
  const HomeGetPostsSuccess({required this.posts});
  @override
  List<Object> get props => [posts];
}

final class HomeGetPostsLoading extends HomeState {}

final class HomeGetPostsFail extends HomeState {
  final String message;
  const HomeGetPostsFail({required this.message});
  @override
  List<Object> get props => [message];
}

//? MAKE POSTS
final class HomeMakePostsSuccess extends HomeState {}

final class HomeMakePostsLoading extends HomeState {}

final class HomeMakePostsFail extends HomeState {
  final String message;
  const HomeMakePostsFail({required this.message});
  @override
  List<Object> get props => [message];
}
