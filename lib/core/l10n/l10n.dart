// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Arabic`
  String get languageCode {
    return Intl.message('Arabic', name: 'languageCode', desc: '', args: []);
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Dive into a paginated list of posts from everyone you follow and new profiles to discover. Infinite scrolling means the feed never ends—stay updated, all day long.`
  String get intro1 {
    return Intl.message(
      'Dive into a paginated list of posts from everyone you follow and new profiles to discover. Infinite scrolling means the feed never ends—stay updated, all day long.',
      name: 'intro1',
      desc: '',
      args: [],
    );
  }

  /// `Easily create new posts, update existing ones, and manage your content. Upload images and videos directly from your device using simple media attachments.`
  String get intro2 {
    return Intl.message(
      'Easily create new posts, update existing ones, and manage your content. Upload images and videos directly from your device using simple media attachments.',
      name: 'intro2',
      desc: '',
      args: [],
    );
  }

  /// `Your account is protected by token-based authentication. Our system handles secure login, logout, and automatic token refresh in the background, keeping your session seamless and secure.`
  String get intro3 {
    return Intl.message(
      'Your account is protected by token-based authentication. Our system handles secure login, logout, and automatic token refresh in the background, keeping your session seamless and secure.',
      name: 'intro3',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterName {
    return Intl.message(
      'Enter your name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?  `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?  ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?  `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?  ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Glad to see you, Again!`
  String get welcomeLogin {
    return Intl.message(
      'Welcome back! Glad to see you, Again!',
      name: 'welcomeLogin',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Register to get started`
  String get welcomeRegister {
    return Intl.message(
      'Hello! Register to get started',
      name: 'welcomeRegister',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `This name is required`
  String get nameRequired {
    return Intl.message(
      'This name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `This email is required`
  String get emailRequired {
    return Intl.message(
      'This email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `This password is required`
  String get passwordRequired {
    return Intl.message(
      'This password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 2 characters`
  String get nameMinLength {
    return Intl.message(
      'Must be at least 2 characters',
      name: 'nameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get valEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'valEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordLength {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordContainUpperCharacter {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordContainUpperCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passwordContainLowerCharacter {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passwordContainLowerCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwordContainNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwordContainNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passwordContainSpecialCharacter {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passwordContainSpecialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with the server.`
  String get connectionTimeout {
    return Intl.message(
      'Connection timeout with the server.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out while sending data.`
  String get sendTimeout {
    return Intl.message(
      'Request timed out while sending data.',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Response reception timed out from the server.`
  String get receiveTimeout {
    return Intl.message(
      'Response reception timed out from the server.',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Security certificate is invalid.`
  String get badCertificate {
    return Intl.message(
      'Security certificate is invalid.',
      name: 'badCertificate',
      desc: '',
      args: [],
    );
  }

  /// `The request was cancelled.`
  String get requestCancelled {
    return Intl.message(
      'The request was cancelled.',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection.`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection.',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unknownError {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Bad request. Please check the data submitted.`
  String get badRequest {
    return Intl.message(
      'Bad request. Please check the data submitted.',
      name: 'badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized access.`
  String get unauthorized {
    return Intl.message(
      'Unauthorized access.',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden access. You do not have permission.`
  String get forbidden {
    return Intl.message(
      'Forbidden access. You do not have permission.',
      name: 'forbidden',
      desc: '',
      args: [],
    );
  }

  /// `The page or service was not found.`
  String get notFound {
    return Intl.message(
      'The page or service was not found.',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `The request timed out.`
  String get requestTimeout {
    return Intl.message(
      'The request timed out.',
      name: 'requestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Data conflict occurred.`
  String get conflict {
    return Intl.message(
      'Data conflict occurred.',
      name: 'conflict',
      desc: '',
      args: [],
    );
  }

  /// `The submitted data is incorrect/invalid.`
  String get unprocessableEntity {
    return Intl.message(
      'The submitted data is incorrect/invalid.',
      name: 'unprocessableEntity',
      desc: '',
      args: [],
    );
  }

  /// `Request limit exceeded. Please try again later.`
  String get tooManyRequests {
    return Intl.message(
      'Request limit exceeded. Please try again later.',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error.`
  String get internalServerError {
    return Intl.message(
      'Internal server error.',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Bad gateway error.`
  String get badGateway {
    return Intl.message(
      'Bad gateway error.',
      name: 'badGateway',
      desc: '',
      args: [],
    );
  }

  /// `Service is currently unavailable.`
  String get serviceUnavailable {
    return Intl.message(
      'Service is currently unavailable.',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Gateway timeout.`
  String get gatewayTimeout {
    return Intl.message(
      'Gateway timeout.',
      name: 'gatewayTimeout',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while processing data from the server. Please try again later.`
  String get dataProcessingError {
    return Intl.message(
      'An error occurred while processing data from the server. Please try again later.',
      name: 'dataProcessingError',
      desc: '',
      args: [],
    );
  }

  /// `Server error ({statusCode}).`
  String serverErrorWithCode(Object statusCode) {
    return Intl.message(
      'Server error ($statusCode).',
      name: 'serverErrorWithCode',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Request error ({statusCode}).`
  String requestErrorWithCode(Object statusCode) {
    return Intl.message(
      'Request error ($statusCode).',
      name: 'requestErrorWithCode',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Unknown error ({statusCode} or no code).`
  String unknownErrorCode(Object statusCode) {
    return Intl.message(
      'Unknown error ($statusCode or no code).',
      name: 'unknownErrorCode',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Session validity has ended. You need to log in again.`
  String get sessionExpired {
    return Intl.message(
      'Session validity has ended. You need to log in again.',
      name: 'sessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `My Ads Management`
  String get myAdsManagement {
    return Intl.message(
      'My Ads Management',
      name: 'myAdsManagement',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get aboutApp {
    return Intl.message('About App', name: 'aboutApp', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Edit post`
  String get editPost {
    return Intl.message('Edit post', name: 'editPost', desc: '', args: []);
  }

  /// `Delete post`
  String get deletePost {
    return Intl.message('Delete post', name: 'deletePost', desc: '', args: []);
  }

  /// `Are you sure you want to delete this post?`
  String get deletePostConfirm {
    return Intl.message(
      'Are you sure you want to delete this post?',
      name: 'deletePostConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Search Posts`
  String get searchPosts {
    return Intl.message(
      'Search Posts',
      name: 'searchPosts',
      desc: '',
      args: [],
    );
  }

  /// `Publish post success`
  String get successCreatePostMessage {
    return Intl.message(
      'Publish post success',
      name: 'successCreatePostMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit post success`
  String get successEditPostMessage {
    return Intl.message(
      'Edit post success',
      name: 'successEditPostMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create Post`
  String get createPost {
    return Intl.message('Create Post', name: 'createPost', desc: '', args: []);
  }

  /// `Edit Post`
  String get EditPost {
    return Intl.message('Edit Post', name: 'EditPost', desc: '', args: []);
  }

  /// `Existing Media`
  String get existingMedia {
    return Intl.message(
      'Existing Media',
      name: 'existingMedia',
      desc: '',
      args: [],
    );
  }

  /// `New Media`
  String get newMedia {
    return Intl.message('New Media', name: 'newMedia', desc: '', args: []);
  }

  /// `Discard`
  String get discard {
    return Intl.message('Discard', name: 'discard', desc: '', args: []);
  }

  /// `Are you sure you want to discard changes?`
  String get discardConfirmation {
    return Intl.message(
      'Are you sure you want to discard changes?',
      name: 'discardConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `publish`
  String get publish {
    return Intl.message('publish', name: 'publish', desc: '', args: []);
  }

  /// `Do you want to exit?`
  String get wantExit {
    return Intl.message(
      'Do you want to exit?',
      name: 'wantExit',
      desc: '',
      args: [],
    );
  }

  /// `you have changes not saved, are you sure to exit?`
  String get exitWithoutSave {
    return Intl.message(
      'you have changes not saved, are you sure to exit?',
      name: 'exitWithoutSave',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Post title`
  String get hintTitlePost {
    return Intl.message(
      'Post title',
      name: 'hintTitlePost',
      desc: '',
      args: [],
    );
  }

  /// `What's on your mind?`
  String get hintContentPost {
    return Intl.message(
      'What\'s on your mind?',
      name: 'hintContentPost',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get requiredTitlePost {
    return Intl.message(
      'Title is required',
      name: 'requiredTitlePost',
      desc: '',
      args: [],
    );
  }

  /// `Content is required`
  String get requiredContentPost {
    return Intl.message(
      'Content is required',
      name: 'requiredContentPost',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResult {
    return Intl.message(
      'No results found',
      name: 'noResult',
      desc: '',
      args: [],
    );
  }

  /// `Type to search`
  String get typeToSearch {
    return Intl.message(
      'Type to search',
      name: 'typeToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Could not open document`
  String get canNotOpenDoc {
    return Intl.message(
      'Could not open document',
      name: 'canNotOpenDoc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
