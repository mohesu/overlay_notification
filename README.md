# overlay_notification

[![Pub](https://img.shields.io/pub/v/overlay_notification?color=blue&style=plastic)](https://pub.dev/packages/overlay_notification)
[![CI](https://github.com/mohesu/overlay_notification/workflows/CI/badge.svg?style=plastic)](https://github.com/mohesu/overlay_notification/actions)

Provider support for `overlay`, make it easy to build **toast** and **In-App notification**.

**this library support ALL platform**

## Interaction

If you want to see the ui effect of this library, just click
here [https://mohesu.github.io/overlay_notification/#/](https://mohesu.github.io/overlay_notification/#/)

## How To Use

#### Add dependencies into you project `pubspec.yaml` file

```yaml
    dependencies:
        overlay_notification: latest_version
```
the latest version is [![Pub](https://img.shields.io/pub/v/overlay_notification?color=blue&style=plastic)](https://pub.dev/packages/overlay_notification)

#### Wrap your AppWidget with `OverlayNotification`

```dart #build()
  return OverlayNotification.global(child: MaterialApp());
```

#### Show toast or simple notifications

```dart
showSimpleNotification(
     Text("this is a message from simple notification"),
     background: Colors.green,
);

toast('this is a message from toast');

```

#### Notification with decoration

```dart
showSimpleNotification(
  const Text('this is a message from simple notification with decoration'),
    margin: const EdgeInsets.all(38),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
      colors: [Colors.green, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight),
     ),
    elevation: 0,
    background: Colors.transparent,
);
```

#### Popup a custom notification

you can custom your notification widget to popup, for example:

```dart
showOverlayNotification((context) {
  return MessageNotification(
    message: 'i love you',
    onReplay: () {
      OverlayNotificationEntry.of(context).dismiss(); //use OverlaySupportEntry to dismiss overlay
      toast('you checked this message');
    },
  );
```

```dart MessageNotification Class
class MessageNotification extends StatelessWidget {
  final VoidCallback onReplay;

  const MessageNotification({Key key, this.onReplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(child: Image.asset('assets/avatar.png'))),
          title: Text('Lily MacDonald'),
          subtitle: Text('Do you want to see a movie?'),
          trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                ///TODO i'm not sure it should be use this widget' BuildContext to create a Dialog
                ///maybe i will give the answer in the future
                if (onReplay != null) onReplay();
              }),
        ),
      ),
    );
  }
}
```

#### Popup a custom overlay

for example, we need create a iOS Style Toast.

```dart
  showOverlay((context, t) {
    return Opacity(
      opacity: t,
      child: IosStyleToast(),
    );
  });
```

```dart
class IosStyleToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text('Succeed')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

## End

if you have some suggestion or advice, please open an issue to let me known.
This will greatly help the improvement of the usability of this project.
Thanks.

## Thanks to

`overlay_support` https://pub.dev/packages/overlay_support

This package is inspired by `overlay_support`, but it is not compatible with `overlay_support` and `overlay_support` is not compatible with `overlay_notification`.
