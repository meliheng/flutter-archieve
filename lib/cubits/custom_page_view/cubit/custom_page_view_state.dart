part of 'custom_page_view_cubit.dart';

sealed class CustomPageViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CustomPageViewInitial extends CustomPageViewState {
  final int selectedIndex;
  final Color? selectedColor;
  final bool isNavigating;

  CustomPageViewInitial({
    required this.selectedIndex, 
    this.selectedColor,
    this.isNavigating = false,
  });

  CustomPageViewInitial copyWith({
    int? selectedIndex, 
    Color? selectedColor,
    bool? isNavigating,
  }) {
    return CustomPageViewInitial(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedColor: selectedColor ?? this.selectedColor,
      isNavigating: isNavigating ?? this.isNavigating,
    );
  }
  
  @override
  List<Object?> get props => [selectedIndex, selectedColor, isNavigating];
}
