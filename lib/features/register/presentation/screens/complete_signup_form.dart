import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kafiil_test/Model/user_data.dart';
import 'package:kafiil_test/core/constant.dart';
import 'package:kafiil_test/core/helpers/custom_textfield_params.dart';
import 'package:kafiil_test/core/routing.dart';
import 'package:kafiil_test/features/appData/cubit/app_data_cubit.dart';
import 'package:kafiil_test/features/register/cubit/register_cubit.dart';
import 'package:kafiil_test/features/register/presentation/widgets/salary_widget.dart';
import 'package:kafiil_test/features/register/presentation/widgets/select_tages.dart';
import 'package:kafiil_test/features/register/presentation/widgets/social_media_widgets.dart';
import 'package:kafiil_test/widgets/custom_button.dart';
import 'package:kafiil_test/widgets/custom_radio_button.dart';
import 'package:kafiil_test/widgets/custom_text.dart';
import 'package:kafiil_test/widgets/custom_textformfieldtitle.dart';
import 'package:kafiil_test/widgets/image_loader.dart';
import 'package:progress_state_button/progress_button.dart';

class CompleteSignupForm extends StatefulWidget {
  final bool isShowOnly;
  final UserData? userData;
  const CompleteSignupForm({super.key, this.userData, this.isShowOnly = false});

  @override
  State<CompleteSignupForm> createState() => _CompleteSignupFormState();
}

class _CompleteSignupFormState extends State<CompleteSignupForm> {
  final TextEditingController birthDayController = TextEditingController();
  final _secondformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              widget.isShowOnly ? 0 : AppContentPadding.horizontalPadding),
      child: SingleChildScrollView(
        physics: widget.isShowOnly
            ? NeverScrollableScrollPhysics()
            : BouncingScrollPhysics(),
        child: Form(
          key: _secondformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              if (!widget.isShowOnly)
                GestureDetector(
                  onTap: () async {
                    await cubit.pickImage(ImageSource.gallery);
                    setState(() {});
                  },
                  child: Center(
                    child: ImageLoader(
                      isFilePath:
                          cubit.secondRegisterForm.avatarPath?.path != null,
                      size: const Size(83, 83),
                      imagePath: cubit.secondRegisterForm.avatarPath?.path ??
                          AppImages.selectImage,
                    ),
                  ),
                ),
              if (!widget.isShowOnly)
                SizedBox(
                  height: 14.h,
                ),
              CustomTextFormFieldWithTitle(
                params: CustomTextFormFieldParams(
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value == '') {
                        cubit.formNotValidate();
                        return 'Please enter your About';
                      } else if (value.length > 1000) {
                        cubit.formNotValidate();
                        return 'About should not exceed 1000 characters';
                      } else if (value.length < 10) {
                        cubit.formNotValidate();
                        return 'About should  exceed 10 characters';
                      }
                      return null;
                    },
                    onSaved: (p0) => cubit.setAbout(p0!),
                    intialValue: widget.userData?.about,
                    isReadOnly: widget.isShowOnly),
                fieldTitle: 'About',
                maxLine: 4,
              ),
              SizedBox(
                height: 14.h,
              ),
              SalaryWidget(
                isShowOnly: widget.isShowOnly,
                paymnet: 'SAR ${widget.userData?.salary.toString()}',
              ),
              SizedBox(
                height: 14.h,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedData = await _selectDate(context);
                  if (pickedData != null) {
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    String formattedDate = formatter.format(pickedData);

                    cubit.serBirthday(formattedDate);
                    birthDayController.text = formattedDate;
                  }
                },
                child: IgnorePointer(
                  child: CustomTextFormFieldWithTitle(
                    fieldTitle: 'Birthday',
                    params: CustomTextFormFieldParams(
                        validator: (value) {
                          DateTime parsedDateTime = DateTime.parse(value!);

                          if (parsedDateTime.isAfter(DateTime.now())) {
                            // Date is in the future, return null
                            return 'Enter Valid Date';
                          } else {
                            return null;
                          }
                        },
                        controller:
                            widget.isShowOnly ? null : birthDayController,
                        suffixIcon: const Icon(
                          Icons.calendar_month,
                          size: 18,
                          color: AppColors.grey_400,
                        ),
                        intialValue: widget.userData?.birthDate,
                        isReadOnly: widget.isShowOnly),
                  ),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              DisplayText(
                textContent: 'Gender',
                textStyle: AppTextStyle().montserratFont,
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedRadioButton(
                    value: 0,
                    onChanged: (p0) {
                      cubit.setGender(0);
                      setState(() {});
                    },
                    selectedValue: widget.isShowOnly
                        ? widget.userData!.gender
                        : cubit.secondRegisterForm.gender!,
                    title: 'Male',
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  AnimatedRadioButton(
                    onChanged: (p0) {
                      cubit.setGender(1);
                      setState(() {});
                    },
                    value: 1,
                    selectedValue: widget.isShowOnly
                        ? widget.userData!.gender
                        : cubit.secondRegisterForm.gender!,
                    title: 'Female',
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              DisplayText(
                textContent: 'Skills',
                textStyle: AppTextStyle().montserratFont,
              ),
              SizedBox(
                height: 12.h,
              ),
              widget.isShowOnly
                  ? Container(
                      width: double.infinity,
                      height: 94.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.grey_50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 24),
                        child: Wrap(
                            children: List.generate(
                                widget.userData!.tags
                                    .length, // number of radio buttons
                                (index) => Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.primary100,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: DisplayText(
                                          textContent:
                                              widget.userData!.tags[index].name,
                                          textStyle: AppTextStyle()
                                              .montserratFont
                                              .copyWith(
                                                  fontSize: 12.sp,
                                                  height: 1,
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      ),
                                    ))),
                      ),
                    )
                  : SelectTage(registerCubit: cubit),
              SizedBox(
                height: 12.h,
              ),
              SocialMediaWidgets(
                isShowenOnly: widget.isShowOnly,
                tageSelected: widget.userData?.favoriteSocialMedia,
              ),
              SizedBox(
                height: 24.h,
              ),
              if (!widget.isShowOnly)
                BlocConsumer<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      current is RegisterLoading ||
                      current is RegisterSuccess ||
                      current is RegisterFailed,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                          weight: 160.w,
                          buttonState: state is RegisterLoading
                              ? ButtonState.loading
                              : state is RegisterSuccess
                                  ? ButtonState.success
                                  : state is RegisterFailed
                                      ? ButtonState.fail
                                      : ButtonState.idle,
                          titleButton: 'Submit',
                          onPressed: () async {
                            if (_secondformKey.currentState!.validate()) {
                              _secondformKey.currentState!.save();
                              if (cubit.validateSecondForm()) {
                                await cubit.register();
                                await Future.delayed(Duration(seconds: 3));
                                NavigatorHelper.pop(context);
                              }
                            }
                          }),
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return pickedDate;
  }
}
