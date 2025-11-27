// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(statusCode) => "Request error (${statusCode}).";

  static String m1(statusCode) => "Server error (${statusCode}).";

  static String m2(statusCode) => "Unknown error (${statusCode} or no code).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?  ",
    ),
    "badCertificate": MessageLookupByLibrary.simpleMessage(
      "Security certificate is invalid.",
    ),
    "badGateway": MessageLookupByLibrary.simpleMessage("Bad gateway error."),
    "badRequest": MessageLookupByLibrary.simpleMessage(
      "Bad request. Please check the data submitted.",
    ),
    "conflict": MessageLookupByLibrary.simpleMessage("Data conflict occurred."),
    "connectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timeout with the server.",
    ),
    "dataProcessingError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while processing data from the server. Please try again later.",
    ),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?  ",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "This email is required",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterName": MessageLookupByLibrary.simpleMessage("Enter your name"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "forbidden": MessageLookupByLibrary.simpleMessage(
      "Forbidden access. You do not have permission.",
    ),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "gatewayTimeout": MessageLookupByLibrary.simpleMessage("Gateway timeout."),
    "internalServerError": MessageLookupByLibrary.simpleMessage(
      "Internal server error.",
    ),
    "intro1": MessageLookupByLibrary.simpleMessage(
      "Dive into a paginated list of posts from everyone you follow and new profiles to discover. Infinite scrolling means the feed never ends—stay updated, all day long.",
    ),
    "intro2": MessageLookupByLibrary.simpleMessage(
      "Easily create new posts, update existing ones, and manage your content. Upload images and videos directly from your device using simple media attachments.",
    ),
    "intro3": MessageLookupByLibrary.simpleMessage(
      "Your account is protected by token-based authentication. Our system handles secure login, logout, and automatic token refresh in the background, keeping your session seamless and secure.",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "nameMinLength": MessageLookupByLibrary.simpleMessage(
      "Must be at least 2 characters",
    ),
    "nameRequired": MessageLookupByLibrary.simpleMessage(
      "This name is required",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection.",
    ),
    "notFound": MessageLookupByLibrary.simpleMessage(
      "The page or service was not found.",
    ),
    "passwordContainLowerCharacter": MessageLookupByLibrary.simpleMessage(
      "Password must contain at least one lowercase letter",
    ),
    "passwordContainNumber": MessageLookupByLibrary.simpleMessage(
      "Password must contain at least one number",
    ),
    "passwordContainSpecialCharacter": MessageLookupByLibrary.simpleMessage(
      "Password must contain at least one special character",
    ),
    "passwordContainUpperCharacter": MessageLookupByLibrary.simpleMessage(
      "Password must contain at least one uppercase letter",
    ),
    "passwordLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "This password is required",
    ),
    "receiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Response reception timed out from the server.",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "The request was cancelled.",
    ),
    "requestErrorWithCode": m0,
    "requestTimeout": MessageLookupByLibrary.simpleMessage(
      "The request timed out.",
    ),
    "sendTimeout": MessageLookupByLibrary.simpleMessage(
      "Request timed out while sending data.",
    ),
    "serverErrorWithCode": m1,
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Service is currently unavailable.",
    ),
    "sessionExpired": MessageLookupByLibrary.simpleMessage(
      "Session validity has ended. You need to log in again.",
    ),
    "tooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Request limit exceeded. Please try again later.",
    ),
    "unauthorized": MessageLookupByLibrary.simpleMessage(
      "Unauthorized access.",
    ),
    "unknownError": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again.",
    ),
    "unknownErrorCode": m2,
    "unprocessableEntity": MessageLookupByLibrary.simpleMessage(
      "The submitted data is incorrect/invalid.",
    ),
    "valEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address",
    ),
    "welcomeLogin": MessageLookupByLibrary.simpleMessage(
      "Welcome back! Glad to see you, Again!",
    ),
    "welcomeRegister": MessageLookupByLibrary.simpleMessage(
      "Hello! Register to get started",
    ),
  };
}
