import 'package:redux/redux.dart';

import 'DraftState.dart';
import 'DraftActions.dart';

final draftReducer = combineReducers<DraftState>([
  TypedReducer<DraftState, UpdateDraftAction>(_updateDraft)
]);

DraftState _updateDraft(DraftState state, UpdateDraftAction action) {
  return state.copyWith(
    newNickname: action.newNickname,
    newAbout: action.newAbout,
    newProfileImagePath: action.newProfileImagePath
  );
}