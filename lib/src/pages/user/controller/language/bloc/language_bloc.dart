import 'dart:collection';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(super.initialState) {
    on<LoadLanguage>((event, emit) {
      emit(LanguageState(event.locale));
      print(event.locale);
    });
  }
  LanguageState get initialState => LanguageState.initial();
}
