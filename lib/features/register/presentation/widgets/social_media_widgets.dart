import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/widgets/animted_checkbox.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/svg_loader.dart';

class SocialMediaWidgets extends StatelessWidget {
  final bool isShowenOnly;
  final List<String>? tageSelected;
  const SocialMediaWidgets(
      {super.key, this.isShowenOnly = false, this.tageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DisplayText(
          textContent: 'Favourite Social Media',
          textStyle: AppTextStyle.montserratFont,
        ),
        SizedBox(
          height: 12.h,
        ),
        Column(
            children: List.generate(
          AppDataCubit.get(context).socialMedia.length,
          (index) => CheckBoxTitle(
            isSelected: tageSelected?.contains(AppDataCubit.get(context)
                    .socialMedia[index]
                    .label
                    ?.toLowerCase()) ??
                false,
            isShownOnly: isShowenOnly,
            onTap: () {
              print('clicked');
              RegisterCubit.get(context).configFavourite(
                  AppDataCubit.get(context).socialMedia[index].label!);
            },
            setState: true,
            title: AppDataCubit.get(context).socialMedia[index].label!,
            icon: const IconLoader(iconPath: AppIcons.facebookIcon),
            textStyle: AppTextStyle.montserratFont.copyWith(
                fontSize: 14.sp, height: 1, color: AppColors.grey_900),
          ),
        ))
        //  CheckBoxTitle(
        //   title: 'Facebook',
        //   icon: const IconLoader(iconPath: AppIcons.facebookIcon),
        //   textStyle: AppTextStyle.montserratFont
        //       .copyWith(fontSize: 14.sp, height: 1, color: AppColors.grey_900),
        // ),
        // CheckBoxTitle(
        //   title: 'Twitter',
        //   icon: const IconLoader(iconPath: AppIcons.twitterIcon),
        //   textStyle: AppTextStyle.montserratFont
        //       .copyWith(fontSize: 14.sp, height: 1, color: AppColors.grey_900),
        // ),
        // CheckBoxTitle(
        //   title: 'LinkedIn',
        //   icon: const IconLoader(iconPath: AppIcons.linkedInIcon),
        //   textStyle: AppTextStyle.montserratFont
        //       .copyWith(fontSize: 14.sp, height: 1, color: AppColors.grey_900),
        // ),
      ],
    );
  }
}
