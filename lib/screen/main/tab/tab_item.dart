import 'package:app_base/common/common.dart';
import 'package:flutter/material.dart';

import 'Search/f_search.dart';
import 'Todo/f_todo.dart';

enum TabItem {
  home(Icons.event_note_outlined, 'Todo', TodoFragment()),
  search(Icons.search, 'Search', SearchFragment());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color:
          // appColors : common.dart의 context_extension.dart를 import해줘야 한다.
          // extension ContextExtension on BuildContext{ ...
          //   -> on 뒤의 자료형을 확장한다. get을 통해서 확장 변수/함수에 접근 할수 있다.
          isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
