import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/features/who_am/repo/who_am_repo.dart';

part 'who_am_state.dart';

class UserCubit extends Cubit<UserState> {
  late final WhoAmRepo _whoAmRepo;
  UserCubit({required WhoAmRepo whoAmRepo})
      : _whoAmRepo = whoAmRepo,
        super(WhoAmInitial());

  static UserCubit get(BuildContext context) => BlocProvider.of(context);
  late UserData userData;
  getUserData() async {
    emit(WhoAmLoading());
    final result = await _whoAmRepo.getUserData();
    result.fold((l) => emit(WhoAmFailed()), (r) {
      userData = r.data;
      emit(WhoAmSuccesfully());
    });
  }
}
