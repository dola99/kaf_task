import 'package:flutter/material.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';

class SelectTage extends StatefulWidget {
  final RegisterCubit registerCubit;
  const SelectTage({super.key, required this.registerCubit});

  @override
  State<SelectTage> createState() => _SelectTageState();
}

class _SelectTageState extends State<SelectTage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0, // Adjust the height according to your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (AppDataCubit.get(context).tags.length / 2).ceil(),
        itemBuilder: (context, index) {
          final firstTagIndex = index * 2;
          final secondTagIndex = firstTagIndex + 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (firstTagIndex < AppDataCubit.get(context).tags.length)
                GestureDetector(
                  onTap: () {
                    widget.registerCubit.configTage(
                        AppDataCubit.get(context).tags[firstTagIndex].value!);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: widget.registerCubit.selectedTags.contains(
                                AppDataCubit.get(context)
                                    .tags[firstTagIndex]
                                    .value!)
                            ? AppColors.primary100
                            : AppColors.bgGrey_50,
                        borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        AppDataCubit.get(context).tags[firstTagIndex].label!),
                  ),
                ),
              if (secondTagIndex < AppDataCubit.get(context).tags.length)
                GestureDetector(
                  onTap: () {
                    widget.registerCubit.configTage(
                        AppDataCubit.get(context).tags[secondTagIndex].value!);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: widget.registerCubit.selectedTags.contains(
                                AppDataCubit.get(context)
                                    .tags[secondTagIndex]
                                    .value!)
                            ? AppColors.primary100
                            : AppColors.bgGrey_50,
                        borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        AppDataCubit.get(context).tags[secondTagIndex].label!),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
