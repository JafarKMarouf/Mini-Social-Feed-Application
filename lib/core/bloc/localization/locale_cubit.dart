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

  Future<void> toggleLocale() async {
    final currentIndex = supportedLocales.indexOf(state.locale);
    final nextIndex = (currentIndex + 1) % supportedLocales.length;
    final nextLocale = supportedLocales[nextIndex];

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));
    await _setLocale(nextLocale);
  }

  Future<void> _setLocale(Locale newLocale) async {
    if (supportedLocales.contains(newLocale)) {
      emit(LocaleState(newLocale, isLoading: false));
      await _prefsService.set<String>(
        AppConstantManager.localeLanguageCode,
        newLocale.languageCode,
      );
    } else {
      emit(state.copyWith(isLoading: false));
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
