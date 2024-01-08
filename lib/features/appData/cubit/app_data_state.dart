part of 'app_data_cubit.dart';

@immutable
sealed class AppDataState {}

final class AppDataInitial extends AppDataState {}

final class AppDataSuccess extends AppDataState {}

final class AppDataFailed extends AppDataState {
  final String errorMessage;
  AppDataFailed({required this.errorMessage});
}
