import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/navbar/cubit/navbar_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // @override
  // void initState() {
  //   NavbarCubit.get(context).init();
  //   super.initState();
  // }

  @override
  void dispose() {
    NavbarCubit.get(context).disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          offset: const Offset(0, 0),
          blurRadius: 7,
          spreadRadius: 0,
        )
      ]),
      child: BottomAppBar(
        height: 75.h,
        color: Colors.white,
        notchMargin: 10.h,
        shape: const CircularNotchedRectangle(),
        child: BlocConsumer<NavbarCubit, NavbarState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(
                  icon: AppIcons.whoAmIcon,
                  page: 0,
                  context,
                  label: "Who Am I",
                ),
                _bottomAppBarItem(
                  icon: AppIcons.countryIcon,
                  page: 1,
                  context,
                  label: "Country",
                ),
                _bottomAppBarItem(
                  icon: AppIcons.cartIcon,
                  page: 2,
                  context,
                  label: "Services",
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => NavbarCubit.get(context).goToTab(page),
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(icon,
                    fit: BoxFit.fill,
                    color: NavbarCubit.get(context).currentPage == page
                        ? AppColors.primaryColor
                        : AppColors.grey_300),
                SizedBox(height: 5.h),
                Text(
                  label,
                  style: AppTextStyle.montserratFont.copyWith(
                    fontWeight: NavbarCubit.get(context).currentPage == page
                        ? FontWeight.w500
                        : FontWeight.w400,
                    color: NavbarCubit.get(context).currentPage == page
                        ? AppColors.primaryColor
                        : AppColors.grey_300,
                    height: 1,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
