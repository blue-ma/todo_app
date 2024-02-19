import 'package:app_base/common/common.dart';
import 'package:app_base/common/theme/custom_theme_app.dart';
import 'package:app_base/data/memory/todo_data_holder.dart';
import 'package:app_base/data/memory/todo_data_notifier.dart';
import 'package:app_base/screen/main/s_main.dart';
import 'package:flutter/material.dart';

import 'common/theme/custom_theme.dart';

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
  static const defaultTheme = CustomTheme.light;
  static bool isForeground = true;

  const App({super.key});

  @override
  State<App> createState() => AppState();
}

/* flutter navigator 방법 4가지
  1. BottomNaviationBar 생성 -> 클릭시 마다 index를 받아서 body에 Wiget을 생성시켜준다. -> 또다른 Screen이 만들어지지는 않는다.
  2. 예를 들어 특정 버튼이 눌려 졌을때 이동하는 상황이라고 설정
     - 버튼 push -> onPressed 처리에서 Navigator.push(context, MaterialPageRoute(context){return NewPage();} -> NewPage는 Scaffold()를 가진 screen
     - 돌아갈때는 Navigator.pop or popUntil()
  3. go_router 라이브러리 사용
     - 특정 버튼이 눌려 졌을때 이동하는 상황이라고 설정
     - main()의 MaterialApp() -> MaterialApp.router(routerConfig: GoRouter( initialLocation : '/', routers [GoRouter(path: '/', name: 'home'), .....]
       -> main에서 전체 route를 만들어 놓고 특정 버튼이 클릭되면 onPressed 처리에서 context.pushName('home') 이동
       -> 돌아갈때는 context.pop()
  4. nav 라이브러리 사용(현재 샘플) pub.dev 참조
*/
/*
전역에서 참조해야 하는 data가 존재한다면 전역변수로 선언하지 말고
최상위 위젯인 AppState내부에 선언해놓고 필요한 위젯들은 최상위 위젯인 AppState에
접근하여 사용
*/
// mixin으로 Nav, WidgetsBingingObserver
class AppState extends State<App> with Nav, WidgetsBindingObserver {
  @override
  GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  final notifier = TodoDataNotifier();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return TodoDataHolder(
          notifier: notifier,
          child: MaterialApp(
            navigatorKey: App.navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Image Finder',
            theme: context.themeType.themeData,
            home: const MainScreen(),
          ),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden: //Flutter 3.13 이하 버전을 쓰신다면 해당 라인을 삭제해주세요.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
