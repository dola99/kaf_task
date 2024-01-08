import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/Model/app_data.dart';
import 'package:kafiil_test/features/appData/repo/app_data_repo.dart';

part 'app_data_state.dart';

class AppDataCubit extends Cubit<AppDataState> {
  late final AppDataRepo _appDataRepo;

  AppDataCubit({required AppDataRepo appDataRepo})
      : _appDataRepo = appDataRepo,
        super(AppDataInitial());

  static AppDataCubit get(BuildContext context) => BlocProvider.of(context);

  late final List<TagElement> types;
  late final List<TagElement> tags;
  late final List<SocialMedia> socialMedia;
  getappData() async {
    final result = await _appDataRepo.getAppData();
    result.fold((l) => emit(AppDataFailed(errorMessage: l)), (r) {
      tags = r.data.tags;
      types = r.data.types;
      socialMedia = r.data.socialMedia;
      emit(AppDataSuccess());
    });
  }
}
