part of 'design_cubit.dart';

@immutable
sealed class DesignState {}

final class DesignInitial extends DesignState {
  final int currentIndex;
  DesignInitial({this.currentIndex = 0});
}
