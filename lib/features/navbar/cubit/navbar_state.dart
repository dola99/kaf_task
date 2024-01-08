part of 'navbar_cubit.dart';

@immutable
sealed class NavbarState {
  final int selectedPage;
  const NavbarState({required this.selectedPage});
}

final class NavbarInitial extends NavbarState {
  const NavbarInitial({required super.selectedPage});
}

final class AnimateToPageState extends NavbarState {
  const AnimateToPageState({required super.selectedPage});
}
