import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'custom_page_view_state.dart';

class CustomPageViewCubit extends Cubit<CustomPageViewState> {
  final PageController pageController = PageController(initialPage: 0);
  
  CustomPageViewCubit() : super(CustomPageViewInitial(selectedIndex: -1));

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void setIndex(int index) {
    final currentState = state;
    if (currentState is! CustomPageViewInitial) {
      return;
    }
    emit(currentState.copyWith(selectedIndex: index));
  }
  
  void setColor(Color color) {
    final currentState = state;
    if (currentState is! CustomPageViewInitial) {
      return;
    }
    emit(currentState.copyWith(selectedColor: color));
  }

  Future<void> navigateToNextPage() async {
    final currentState = state;
    if (currentState is! CustomPageViewInitial || currentState.isNavigating) {
      return;
    }
    
    emit(currentState.copyWith(isNavigating: true));
    
    try {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      final newState = state;
      if (newState is CustomPageViewInitial) {
        emit(newState.copyWith(isNavigating: false));
      }
    }
  }
}
