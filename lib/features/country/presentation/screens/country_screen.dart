import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/fonts.dart';
import 'package:kafiil_test/features/country/cubit/country_cubit.dart';
import 'package:kafiil_test/features/country/presentation/widgets/country_listview.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/number_pagenations.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    CountryCubit.get(context).getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppContentPadding.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer<CountryCubit, CountryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CountryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CountrySuccesfully ||
                      state is CountryNoLoading) {
                    final cubit = CountryCubit.get(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayText(
                          textContent: 'Countries',
                          textStyle: AppTextStyle().montserratFont.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: AppColors.grey_900),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CountryListView(
                          countryList: cubit.data,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        NumberPagination(
                          onPageChanged: (int pageNumber) async {
                            await CountryCubit.get(context)
                                .getCountries(pageNumber: pageNumber);
                          },
                          threshold: 3,
                          pageTotal:
                              CountryCubit.get(context).pagination.totalPages,
                          pageInit: 1, // picked number when init page
                          colorPrimary: AppColors.grey_800,
                          borderColor: AppColors.grey_200,
                          fontFamily: FontUitls.montserratFontFamily,
                          colorSub: AppColors.grey_200,
                          // Set the maximum number of visible pages.
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
