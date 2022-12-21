import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_notification/overlay_notification.dart';

import 'pages/page_main.dart';
import 'pages/page_multi_overlay_support.dart';
import 'pages/page_with_ime.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  kNotificationSlideDuration = const Duration(milliseconds: 500);
  kNotificationDuration = const Duration(milliseconds: 1500);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OverlayNotification.global(
      child: MaterialApp(
        title: 'Overlay Support Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _ExampleDrawer(),
      ),
    );
  }
}

class _ExampleDrawer extends StatefulWidget {
  @override
  _ExampleDrawerState createState() => _ExampleDrawerState();
}

class _ExampleDrawerState extends State<_ExampleDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: _NavigationTiles(),
      ),
      appBar: AppBar(
        title: const Text('Overlay Support Example'),
        leading: IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                color: Theme.of(context).primaryIconTheme.color,
                progress: ProxyAnimation(kAlwaysDismissedAnimation)),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            }),
      ),
      body: const HomePage(),
    );
  }
}

class _NavigationTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.all(0),
              child: Container(color: Theme.of(context).colorScheme.secondary),
            ),
            ListTile(
              title: const Text('Main'),
              selected: true,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const Divider(height: 0, indent: 16),
            ListTile(
              title: const Text('Multi Screen'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageMultiOverlaySupport()));
              },
            ),
            const Divider(height: 0, indent: 16),
            ListTile(
              title: const Text('Star On GitHub'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageWithIme()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
