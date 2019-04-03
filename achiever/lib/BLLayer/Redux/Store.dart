import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

import 'AppState.dart';
import 'AppReducer.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ]
  );
}
