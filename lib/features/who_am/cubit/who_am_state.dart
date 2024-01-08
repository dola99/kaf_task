part of 'who_am_cubit.dart';

@immutable
sealed class UserState {}

final class WhoAmInitial extends UserState {}

final class WhoAmLoading extends UserState {}

final class WhoAmSuccesfully extends UserState {}

final class WhoAmFailed extends UserState {}
