import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/Model/service_model.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/services/presentation/widgets/service_card.dart';
import 'package:kafiil_test/widgets/custom_text.dart';

class ServiceWithTitle extends StatelessWidget {
  final String title;
  final List<ServiceProduct> serviceProduct;
  const ServiceWithTitle(
      {super.key, required this.title, required this.serviceProduct});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DisplayText(
          textContent: title,
          textStyle: AppTextStyle().montserratFont.copyWith(
              height: 1,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.grey_900),
        ),
        SizedBox(
          height: 30.h,
        ),
        SizedBox(
            height: 210.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: serviceProduct.length,
              itemBuilder: (context, index) =>
                  ServiceCard(serviceProduct: serviceProduct[index]),
            ))
      ],
    );
  }
}
