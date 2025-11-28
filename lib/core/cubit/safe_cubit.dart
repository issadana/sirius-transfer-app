import 'package:flutter_bloc/flutter_bloc.dart';

// Base Cubit class that prevents emitting after close
abstract class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  @override
  void emit(State state) {
    //Check on isClosed to avoid exceptions
    if (!isClosed) {
      super.emit(state);
    }
  }
}
