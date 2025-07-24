import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'design_state.dart';

class DesignCubit extends Cubit<DesignState> {
  DesignCubit() : super(DesignInitial());

  void changeIndex(int index) {
    emit(DesignInitial(currentIndex: index));
  }
}
