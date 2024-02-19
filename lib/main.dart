import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';

/* 비동기 프로그램
  async / await / Futrue : 1회만 응답을 돌려받는 경우
  async* / yield / Stream : timer와 같이 지속적으로 응답을 돌려 받는 경우
* */
void main() async {
  // 1. easyLocalization : 초기화 2항목
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //
  await AppPreferences.init();

  // 2. easyLocalization : josn형태의 언어별 json 파일 위치
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}
