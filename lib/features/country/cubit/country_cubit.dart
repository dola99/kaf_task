import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/Model/country_model.dart';
import 'package:kafiil_test/features/country/repo/country_repo.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepo _countryRepo;
  CountryCubit({required CountryRepo countryRepo})
      : _countryRepo = countryRepo,
        super(CountryInitial());

  static CountryCubit get(BuildContext context) => BlocProvider.of(context);

  late List<Country> data;
  late PaginationData pagination;
  int currentPage = 1;
  Map<int, List<Country>> countryCache = {};

  Future<void> getCountries({int? pageNumber}) async {
    try {
      pageNumber != null ? emit(CountryNoLoading()) : emit(CountryLoading());

      // Check if data is already cached
      if (countryCache.containsKey(pageNumber)) {
        // Use cached data
        data = countryCache[pageNumber ?? 1]!;
        emit(CountrySuccesfully());
      } else {
        // Fetch data from the network
        final result = await _countryRepo.getCountry(page: pageNumber ?? 1);

        result.fold((l) {
          emit(CountryFailed());
        }, (r) {
          data = r.data;
          pagination = r.pagination;

          countryCache[pageNumber ?? 1] = data;

          emit(CountrySuccesfully());
        });
      }
    } catch (e) {
      emit(CountryFailed());
    }
  }
}
