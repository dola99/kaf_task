import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/helpers/custom_textfield_params.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/custom_textformfieldtitle.dart';

class SalaryWidget extends StatefulWidget {
  final bool isShowOnly;
  final String? paymnet;
  const SalaryWidget({super.key, this.paymnet, this.isShowOnly = false});

  @override
  State<SalaryWidget> createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _moneyValueAnimation;
  int moneyValue = 100;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _moneyValueAnimation = IntTween(
      begin: moneyValue,
      end: moneyValue,
    ).animate(_animationController);
  }

  void updateMoneyValue(int delta) {
    if (((moneyValue + delta) < 100) || ((moneyValue + delta) > 1000)) {
      return;
    }
    int newMoneyValue = moneyValue + delta;
    _moneyValueAnimation = IntTween(
      begin: moneyValue,
      end: newMoneyValue,
    ).animate(_animationController);
    _animationController.forward(from: 0);
    setState(() {
      moneyValue = newMoneyValue;
    });
    RegisterCubit.get(context).setSalary(moneyValue);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
            child: CustomTextFormFieldWithTitle(
          fieldTitle: 'Salary',
          params: CustomTextFormFieldParams(
              intialValue: widget.isShowOnly ? widget.paymnet : ''),
        )),
        if (!widget.isShowOnly)
          Padding(
            padding: EdgeInsets.only(top: 27.h, left: 25.w, right: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => updateMoneyValue(-100),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                            color: const Color(0xffbab5b5).withOpacity(.20))
                      ],
                      color: AppColors.bgGrey_900,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.remove_rounded,
                        size: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _moneyValueAnimation,
                  builder: (context, child) {
                    return DisplayText(
                      textContent: 'SAR ${_moneyValueAnimation.value}',
                      textStyle: AppTextStyle().montserratFont.copyWith(
                          height: 1, fontSize: 16, color: AppColors.grey_800),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () => updateMoneyValue(100),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                            color: const Color(0xffbab5b5).withOpacity(.20))
                      ],
                      color: AppColors.bgGrey_900,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_rounded,
                        size: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
