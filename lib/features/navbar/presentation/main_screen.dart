import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/features/navbar/cubit/navbar_cubit.dart';
import 'package:kafiil_test/features/navbar/presentation/navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    NavbarCubit.get(context).pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: BlocConsumer<NavbarCubit, NavbarState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NavbarCubit.get(context);
          return PageView(
              onPageChanged: cubit.animateToTab,
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              children: [...cubit.pages]);
        },
      ),
    );
  }
}
