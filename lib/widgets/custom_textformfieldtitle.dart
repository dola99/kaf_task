import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/helpers/custom_textfield_params.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/custom_textformfield.dart';

class CustomTextFormFieldWithTitle extends StatelessWidget {
  final String fieldTitle;
  final bool isObscureText;
  final bool textHiddenByDefult;
  final int? maxLine;
  final CustomTextFormFieldParams? params;

  const CustomTextFormFieldWithTitle(
      {super.key,
      this.isObscureText = false,
      this.maxLine,
      required this.params,
      this.textHiddenByDefult = false,
      required this.fieldTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DisplayText(
            textContent: fieldTitle,
            textStyle: AppTextStyle.montserratFont,
          ),
          SizedBox(
            height: 12.h,
          ),
          CustomTextFormField(
            params: params!,
          ),
        ],
      ),
    );
  }
}
