part of 'country_cubit.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class CountrySuccesfully extends CountryState {}

final class CountryLoading extends CountryState {}

final class CountryNoLoading extends CountryState {}

final class CountryFailed extends CountryState {}
