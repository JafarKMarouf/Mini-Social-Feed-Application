import 'package:flutter/cupertino.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';

class Validator {
  Validator._();

  static final locale = AppLocalizations();

  // ==================== BASIC VALIDATORS ====================
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? minLength(String? value, int minLength, {String? message}) {
    if (value == null || value.isEmpty) return null;

    if (value.length < minLength) {
      return message;
    }
    return null;
  }

  static String? email(String? value, {String? message}) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim().toLowerCase())) {
      return message ?? locale.valEmail;
    }
    return null;
  }

  // ==================== NAME VALIDATORS ====================

  static String? name(String? value, {String? message}) {
    // Check if required
    final requiredError = required(value, message: locale.nameRequired);
    if (requiredError != null) return requiredError;

    // Check minimum length
    final lengthError = minLength(value, 2, message: locale.nameMinLength);
    if (lengthError != null) return lengthError;

    if (!RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$').hasMatch(value!)) {
      return message ?? 'الاسم يجب أن يحتوي على أحرف فقط';
    }

    return null;
  }

  // ==================== COMPLETE FIELD VALIDATORS ====================

  static String? emailRequired(String? value, {String? message}) {
    final requiredError = required(value, message: locale.emailRequired);
    if (requiredError != null) return requiredError;

    return email(value, message: message);
  }

  static String? passwordRequired(String? value, {String? message}) {
    final requiredError = required(value, message: locale.passwordRequired);
    if (requiredError != null) return requiredError;
    return null;
  }

  static String? passwordLogin(String? value, {String? message}) {
    final requiredError = required(value, message: locale.passwordRequired);
    if (requiredError != null) return requiredError;

    if (value == null || value.isEmpty) return null;

    if (value.length < 8) {
      return message ?? locale.passwordLength;
    }
    return null;
  }

  static String? passwordRegister(String? value, {String? message}) {
    final requiredError = required(value, message: locale.passwordRequired);
    if (requiredError != null) return requiredError;

    if (value == null || value.isEmpty) return null;

    if (value.length < 8) {
      return message ?? locale.passwordLength;
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return message ?? locale.passwordContainUpperCharacter;
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return message ?? locale.passwordContainLowerCharacter;
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return message ?? locale.passwordContainNumber;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return message ?? locale.passwordContainSpecialCharacter;
    }

    return null;
  }

  // ==================== UTILITY METHODS ====================

  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }

  // Form validation method
  static bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }
}
