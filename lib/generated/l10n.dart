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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Via social media`
  String get via_social_media {
    return Intl.message(
      'Via social media',
      name: 'via_social_media',
      desc: '',
      args: [],
    );
  }

  /// `Let's explore\nKinds of coffee`
  String get onboarding_1 {
    return Intl.message(
      'Let\'s explore\nKinds of coffee',
      name: 'onboarding_1',
      desc: '',
      args: [],
    );
  }

  /// `Let's explore various coffee flavors with us with just few clicks`
  String get onboarding_sub_1 {
    return Intl.message(
      'Let\'s explore various coffee flavors with us with just few clicks',
      name: 'onboarding_sub_1',
      desc: '',
      args: [],
    );
  }

  /// `Monitor and\nvisit the cafe`
  String get onboarding_2 {
    return Intl.message(
      'Monitor and\nvisit the cafe',
      name: 'onboarding_2',
      desc: '',
      args: [],
    );
  }

  /// `Monitor the state of the cafe and visit with your friends`
  String get onboarding_sub_2 {
    return Intl.message(
      'Monitor the state of the cafe and visit with your friends',
      name: 'onboarding_sub_2',
      desc: '',
      args: [],
    );
  }

  /// `Get ready for the\nnewest coffee`
  String get onboarding_3 {
    return Intl.message(
      'Get ready for the\nnewest coffee',
      name: 'onboarding_3',
      desc: '',
      args: [],
    );
  }

  /// `Get ready to try the newest coffee variant with your friends`
  String get onboarding_sub_3 {
    return Intl.message(
      'Get ready to try the newest coffee variant with your friends',
      name: 'onboarding_sub_3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
