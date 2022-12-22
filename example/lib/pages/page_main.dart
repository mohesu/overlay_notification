import 'dart:async';
import 'dart:math';

import 'package:example/notification/custom_animation.dart';
import 'package:example/notification/custom_notification.dart';
import 'package:example/notification/ios_toast.dart';
import 'package:flutter/material.dart';
import 'package:overlay_notification/overlay_notification.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _Section(title: 'Notification', children: <Widget>[
          ElevatedButton(
            onPressed: () {
              showSimpleNotification(
                const Text(
                    'this is a message from simple notification with decoration'),
                margin: const EdgeInsets.all(38),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                elevation: 0,
              );
            },
            child: const Text(
              'Auto Dismiss Notification',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showSimpleNotification(
                const Text('you got a simple message'),
                trailing: Builder(builder: (context) {
                  return TextButton(
                      onPressed: () {
                        OverlayNotificationEntry.of(context)!.dismiss();
                      },
                      child: const Text('Dismiss',
                          style: TextStyle(color: Colors.amber)));
                }),
                background: Colors.green,
                autoDismiss: false,
                slideDismissDirection: DismissDirection.up,
              );
            },
            child: const Text('Fixed Notification'),
          ),
          ElevatedButton(
            child: const Text('Bottom Notification'),
            onPressed: () {
              showSimpleNotification(
                const Text('Hello'),
                position: NotificationPosition.bottom,
                slideDismissDirection: DismissDirection.down,
              );
            },
          )
        ]),
        _Section(title: 'Custom notification', children: <Widget>[
          ElevatedButton(
            onPressed: () {
              showOverlayNotification((context) {
                return MessageNotification(
                  message: messages[3],
                  onReply: () {
                    OverlayNotificationEntry.of(context)!.dismiss();
                    toast('you checked this message');
                  },
                );
              }, duration: const Duration(milliseconds: 4000));
            },
            child: const Text('custom message notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              final random = Random();
              for (var i = 0; i < messages.length; i++) {
                await Future.delayed(
                    Duration(milliseconds: 200 + random.nextInt(200)));
                showOverlayNotification((context) {
                  return MessageNotification(
                    message: messages[i],
                    onReply: () {
                      OverlayNotificationEntry.of(context)?.dismiss();
                      toast('you checked this message');
                    },
                  );
                },
                    duration: const Duration(milliseconds: 4000),
                    key: const ValueKey('message'));
              }
            },
            child: const Text('message sequence'),
          ),
        ]),
        _Section(title: 'toast', children: [
          ElevatedButton(
            onPressed: () {
              toast('this is a message from toast');
            },
            child: const Text('toast'),
          )
        ]),
        _Section(title: 'custom', children: [
          ElevatedButton(
            onPressed: () {
              showOverlay((_, t) {
                return Theme(
                  data: Theme.of(context),
                  child: Opacity(
                    opacity: t,
                    child: const IosStyleToast(),
                  ),
                );
              }, key: const ValueKey('hello'));
            },
            child: const Text('show iOS Style Dialog'),
          ),
          ElevatedButton(
            onPressed: () {
              showOverlay((context, t) {
                return CustomAnimationToast(value: t);
              }, key: const ValueKey('hello'), curve: Curves.decelerate);
            },
            child: const Text('show custom animation overlay'),
          ),
          ElevatedButton(
            onPressed: () {
              showOverlay((context, t) {
                return Container(
                  color: Color.lerp(Colors.transparent, Colors.black54, t),
                  child: FractionalTranslation(
                    translation: Offset.lerp(
                        const Offset(0, -1), const Offset(0, 0), t)!,
                    child: Column(
                      children: <Widget>[
                        MessageNotification(
                          message: 'Hello',
                          onReply: () {
                            OverlayNotificationEntry.of(context)!.dismiss();
                          },
                          key: const ModalKey(Object()),
                        ),
                      ],
                    ),
                  ),
                );
              }, duration: Duration.zero);
            },
            child: const Text('show notification with barrier'),
          )
        ])
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;

  final List<Widget> children;

  const _Section({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          _Title(title: title),
          Wrap(spacing: 8, children: children),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 10, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }
}
