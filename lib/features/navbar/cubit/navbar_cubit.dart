import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/features/country/presentation/screens/country_screen.dart';
import 'package:kafiil_test/features/services/presentation/screens/services_screen.dart';
import 'package:kafiil_test/features/who_am/presentation/screens/who_am_screen.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarInitial(selectedPage: 0));

  static NavbarCubit get(BuildContext context) => BlocProvider.of(context);
  late PageController pageController;

  int currentPage = 0;

  List<Widget> pages = [
    const UserScreen(),
    const CountryScreen(),
    const ServicesScreen(),
  ];

  void init() {
    pageController = PageController(initialPage: 0);
  }

  void goToTab(int page) {
    currentPage = page;
    pageController.jumpToPage(page);
    emit(AnimateToPageState(selectedPage: page));
  }

  void animateToTab(int page) {
    currentPage = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 0), curve: Curves.ease);
    emit(AnimateToPageState(selectedPage: page));
  }

  void disposeController() {
    pageController.dispose();
  }
}
