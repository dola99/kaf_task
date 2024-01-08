import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/Model/country_model.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/widgets/custom_text.dart';

class CountryListView extends StatelessWidget {
  final List<Country> countryList;
  const CountryListView({super.key, required this.countryList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      height: 330.h,
      decoration: BoxDecoration(
        color: AppColors.bgGrey_900,
        boxShadow: const [
          BoxShadow(
              color: AppColors.grey_100, offset: Offset(0, 4), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            width: 322.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey_50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DisplayText(
                    textContent: "Country",
                    textStyle: AppTextStyle().montserratFont.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey_500,
                        fontSize: 12,
                        height: 1),
                  ),
                  DisplayText(
                    textContent: "Capital",
                    textStyle: AppTextStyle().montserratFont.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey_500,
                        fontSize: 12,
                        height: 1),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: SizedBox(
              height: 280,
              child: ListView.builder(
                itemCount: countryList.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: DisplayText(
                              textContent: countryList[index].name,
                              textStyle: AppTextStyle().montserratFont.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey_900,
                                  fontSize: 12,
                                  height: 1),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: DisplayText(
                              textContent: countryList[index].capital,
                              textStyle: AppTextStyle().montserratFont.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey_900,
                                  fontSize: 12,
                                  height: 1),
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
