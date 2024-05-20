part of 'language_bloc.dart';

class LanguageState {
  final Locale locale;

  LanguageState(this.locale);

  factory LanguageState.initial() => LanguageState(LocalizationService.locale!);

  LanguageState copyWith(Locale locale) => LanguageState(locale);

  List<Object> get props => [locale];
}
