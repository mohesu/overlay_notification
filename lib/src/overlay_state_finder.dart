import 'dart:collection';

import 'package:flutter/material.dart';

import '../overlay_notification.dart';

final GlobalKey<OverlayNotificationState> _keyFinder =
    GlobalKey(debugLabel: 'overlay_support');

OverlayNotificationState? findOverlayState({BuildContext? context}) {
  if (context == null) {
    assert(
      _debugInitialized,
      'Global OverlayNotification Not Initialized ! \n'
      'ensure your app wrapped widget OverlayNotification.global',
    );
    final state = _keyFinder.currentState;
    assert(() {
      if (state == null) {
        throw FlutterError(
            '''we can not find OverlayNotificationState in your app.
         
         do you declare OverlayNotification.global you app widget tree like this?
         
         OverlayNotification.global(
           child: MaterialApp(
             title: 'Overlay Support Example',
             home: HomePage(),
           ),
         )
      
      ''');
      }
      return true;
    }());
    return state;
  }
  final overlayNotificationState =
      context.findAncestorStateOfType<OverlayNotificationState>();
  return overlayNotificationState;
}

bool _debugInitialized = false;

class OverlayNotification extends StatelessWidget {
  final Widget child;

  final ToastThemeData? toastTheme;

  final bool global;

  const OverlayNotification({
    Key? key,
    required this.child,
    this.toastTheme,
    this.global = true,
  }) : super(key: key);

  const OverlayNotification.global({
    Key? key,
    required this.child,
    this.toastTheme,
  }) : global = true;

  const OverlayNotification.local({
    Key? key,
    required this.child,
    this.toastTheme,
  }) : global = false;

  OverlayNotificationState? of(BuildContext context) {
    return context.findAncestorStateOfType<OverlayNotificationState>();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayNotificationTheme(
      toastTheme: toastTheme ??
          OverlayNotificationTheme.toast(context) ??
          ToastThemeData(),
      child: global
          ? _GlobalOverlayNotification(child: child)
          : _LocalOverlayNotification(child: child),
    );
  }
}

class _GlobalOverlayNotification extends StatefulWidget {
  final Widget child;

  _GlobalOverlayNotification({required this.child}) : super(key: _keyFinder);

  @override
  StatefulElement createElement() {
    _debugInitialized = true;
    return super.createElement();
  }

  @override
  _GlobalOverlayNotificationState createState() =>
      _GlobalOverlayNotificationState();
}

class _GlobalOverlayNotificationState
    extends OverlayNotificationState<_GlobalOverlayNotification> {
  @override
  Widget build(BuildContext context) {
    assert(() {
      if (context.findAncestorWidgetOfExactType<_GlobalOverlayNotification>() !=
          null) {
        throw FlutterError(
            'There is already an OverlayNotification.global in the Widget tree.');
      }
      return true;
    }());
    return widget.child;
  }

  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;
    void visitor(Element element) {
      if (navigator != null) return;

      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(navigator != null,
        '''It looks like you are not using Navigator in your app.
         
         do you wrapped you app widget like this?
         
         OverlayNotification(
           child: MaterialApp(
             title: 'Overlay Notification Example',
             home: HomePage(),
           ),
         )
      
      ''');
    return navigator?.overlay;
  }
}

class _LocalOverlayNotification extends StatefulWidget {
  final Widget child;

  const _LocalOverlayNotification({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _LocalOverlayNotificationState createState() =>
      _LocalOverlayNotificationState();
}

class _LocalOverlayNotificationState
    extends OverlayNotificationState<_LocalOverlayNotification> {
  final GlobalKey<OverlayState> _overlayStateKey = GlobalKey();

  @override
  OverlayState? get overlayState => _overlayStateKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: _overlayStateKey,
      initialEntries: [OverlayEntry(builder: (context) => widget.child)],
    );
  }
}

abstract class OverlayNotificationState<T extends StatefulWidget>
    extends State<T> {
  final Map<Key, OverlayNotificationEntry> _entries = HashMap();

  OverlayState? get overlayState;

  OverlayNotificationEntry? getEntry({required Key key}) {
    return _entries[key];
  }

  void addEntry(OverlayNotificationEntry entry, {required Key key}) {
    _entries[key] = entry;
  }

  void removeEntry({required Key key}) {
    _entries.remove(key);
  }
}
