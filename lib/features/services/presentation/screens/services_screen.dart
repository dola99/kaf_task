import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/services/cubit/services_cubit.dart';
import 'package:kafiil_test/features/services/presentation/widgets/service_with_title.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    ServicesCubit.get(context).getData();
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
              BlocConsumer<ServicesCubit, ServicesState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      ServiceWithTitle(
                        title: "Services",
                        serviceProduct: ServicesCubit.get(context).services,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ServiceWithTitle(
                        title: "Popular Services",
                        serviceProduct:
                            ServicesCubit.get(context).popularServices,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
