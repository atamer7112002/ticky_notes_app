import 'package:flutter_bloc/flutter_bloc.dart';

/// A very simple BlocObserver that prints state changes and errors.
///
/// This is mainly useful for debugging while you are learning Bloc/Cubit.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // This will print something like: NotesCubit Change { currentState: ..., nextState: ... }
    // You can see it in the debug console.
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // ignore: avoid_print
    print('Error in ${bloc.runtimeType} -> $error');
  }
}


