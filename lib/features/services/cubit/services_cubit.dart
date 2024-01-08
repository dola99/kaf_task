import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/Model/service_model.dart';
import 'package:kafiil_test/features/services/repo/services_repo.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepo _serviceRepo;
  ServicesCubit({required ServicesRepo servicesRepo})
      : _serviceRepo = servicesRepo,
        super(ServicesInitial());
  static ServicesCubit get(BuildContext context) => BlocProvider.of(context);

  List<ServiceProduct> popularServices = [];
  List<ServiceProduct> services = [];
  Map<String, ServicesState> stateList = {};

  getData() async {
    await Future.wait([
      getService(),
      getPopularService(),
    ]);
  }

  Future<void> getService() async {
    try {
      stateList['Services'] = ServicesLoading();
      emit(ServicesLoading());
      final result = await _serviceRepo.getServices();
      result.fold((l) {
        stateList['Services'] = ServicesFailed();

        emit(ServicesFailed());
      }, (r) {
        services = r.data;
        stateList['Services'] = ServicesSuccesfully();

        emit(ServicesFailed());
      });
    } catch (e) {
      emit(ServicesFailed());
    }
  }

  Future<void> getPopularService() async {
    try {
      stateList['Popular Services'] = ServicesLoading();
      emit(ServicesLoading());
      final result = await _serviceRepo.getPopularService();
      result.fold((l) {
        stateList['Popular Services'] = ServicesSuccesfully();
        emit(ServicesSuccesfully());
      }, (r) {
        popularServices = r.data;
        stateList['Popular Services'] = ServicesFailed();
        emit(ServicesFailed());
      });
    } catch (e) {
      emit(ServicesFailed());
    }
  }
}
