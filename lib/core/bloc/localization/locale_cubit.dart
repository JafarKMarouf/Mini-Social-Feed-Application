import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/constants/app_constant_manager.dart';
import 'package:mini_social_feed/core/services/shared_preference_service.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  final SharedPreferenceService _prefsService;

  LocaleCubit(this._prefsService) : super(const LocaleState(Locale('en')));

  void toggleLocale() {
    final currentIndex = supportedLocales.indexOf(state.locale);
    final nextIndex = (currentIndex + 1) % supportedLocales.length;
    final nextLocale = supportedLocales[nextIndex];

    _setLocale(nextLocale);
  }

  Future<void> _setLocale(Locale newLocale) async {
    if (supportedLocales.contains(newLocale)) {
      emit(LocaleState(newLocale));
      await _prefsService.set<String>(
        AppConstantManager.localeLanguageCode,
        newLocale.languageCode,
      );
    } else {
      debugPrint(
        'Unsupported localization requested: ${newLocale.languageCode}',
      );
    }
  }

  Future<Locale> _loadLocale() async {
    final String? savedCode = _prefsService.get<String>(
      AppConstantManager.localeLanguageCode,
    );
    if (savedCode != null) {
      final savedLocale = Locale(savedCode);
      if (supportedLocales.contains(savedLocale)) {
        return savedLocale;
      }
    }
    return supportedLocales.first;
  }

  Future<void> setInitialLocale() async {
    final Locale initialLocale = await _loadLocale();
    emit(LocaleState(initialLocale));
  }
}
