import 'package:flutter/material.dart';
import 'package:prj_gateway/utils/app_colors.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items})
      : super(key: key);

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          /// Check if curent tab can be popped
          if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ??
              false) {
            widget.items[_selectedTab].navigatorkey?.currentState?.pop();
            return false;
          } else {
            // if current tab can't be popped then use the root navigator
            return true;
          }
        },
        child: Scaffold(
            // appBar: const CustomAppBar(),

            /// Using indexedStack to maintain the order of the tabs and the state of the
            /// previously opened tab
            body: IndexedStack(
              index: _selectedTab,
              children: widget.items
                  .map((page) => Navigator(
                        /// Each tab is wrapped in a Navigator so that naigation in
                        /// one tab can be independent of the other tabs
                        key: page.navigatorkey,
                        onGenerateInitialRoutes: (navigator, initialRoute) {
                          return [
                            MaterialPageRoute(builder: (context) => page.tab)
                          ];
                        },
                      ))
                  .toList(),
            ),

            /// Define the persistent bottom bar
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF87CA80),
                borderRadius: const BorderRadius.only(
                    // topLeft: Radius.circular(10),
                    // topRight: Radius.circular(10),
                    ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.33),
                    spreadRadius: 0.5,
                    blurRadius: 3,
                    offset: const Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: NavigationBar(
                // type: BottomNavigationBarType.fixed, // This is all you need!
                selectedIndex: _selectedTab,
                // currentIndex: _selectedTab,
                onDestinationSelected: (index) {
                  /// Check if the tab that the user is pressing is currently selected
                  if (index == _selectedTab) {
                    /// if you want to pop the current tab to its root then use
                    widget.items[index].navigatorkey?.currentState
                        ?.popUntil((route) => route.isFirst);

                    /// if you want to pop the current tab to its last page
                    /// then use
                    // widget.items[index].navigatorkey?.currentState?.pop();
                  } else {
                    setState(() {
                      _selectedTab = index;
                    });
                  }
                },
                destinations: widget.items
                    .map((item) => NavigationDestination(
                          icon: Icon(item.icon, color: AppColors.secondary),
                          label: item.title,
                          selectedIcon: Icon(
                            item.icon,
                            color: AppColors.focus,
                          ),
                        ))
                    .toList(),
              ),
            )));
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}
