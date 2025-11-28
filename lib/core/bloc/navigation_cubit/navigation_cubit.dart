import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(int index) : super(NavigationState(selectedIndex: index));

  void setIndex(int index) {
    emit(NavigationState(selectedIndex: index));
  }
}
