import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/Model/service_model.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/image_loader.dart';
import 'package:kafiil_test/widgets/svg_loader.dart';

class ServiceCard extends StatelessWidget {
  final ServiceProduct serviceProduct;
  const ServiceCard({super.key, required this.serviceProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.w,
      height: 192.h,
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.bgGrey_900,
        boxShadow: [
          BoxShadow(
              color: AppColors.bgGrey_300.withOpacity(.20),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 103.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.grey_300,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageLoader(
                      imagePath: serviceProduct.mainImage,
                      isNetworkImage: true,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.w,
                  left: 10.w,
                  child: Container(
                    height: 26.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: DisplayText(
                        textContent: '\$ ${serviceProduct.price}',
                        textStyle: AppTextStyle().montserratFont.copyWith(
                            height: 1,
                            fontSize: 12.sp,
                            color: AppColors.bgGrey_900),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            DisplayText(
              textContent: serviceProduct.title,
              textStyle: AppTextStyle()
                  .montserratFont
                  .copyWith(height: 1, fontSize: 11, color: AppColors.grey_900),
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconLoader(iconPath: AppIcons.starIcon),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: DisplayText(
                    textContent: '(${serviceProduct.averageRating})',
                    textStyle: AppTextStyle().montserratFont.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: AppColors.warning),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  height: 15.h,
                  width: 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.grey_300),
                ),
                SizedBox(
                  width: 8.w,
                ),
                const IconLoader(iconPath: AppIcons.bagIcon),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: DisplayText(
                    textContent: '${serviceProduct.completedSalesCount}',
                    textStyle: AppTextStyle().montserratFont.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: AppColors.grey_600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
