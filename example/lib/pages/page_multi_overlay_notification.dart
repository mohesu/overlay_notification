import 'package:flutter/material.dart';
import 'package:overlay_notification/overlay_notification.dart';

class PageMultiOverlaySupport extends StatelessWidget {

const PageMultiOverlaySupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('multi screen.')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 8,
          spacing: 8,
          children: [
            _Screen(),
            _Screen(),
            _Screen(),
            _Screen(),
          ],
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 640,
      foregroundDecoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF222222), width: 1),
          left: BorderSide(color: Color(0xFF222222), width: 1),
          right: BorderSide(color: Color(0x88222222), width: 1),
          bottom: BorderSide(color: Color(0x88222222), width: 1),
        ),
      ),
      child: const ClipRect(
        child: OverlayNotification.local(
          child: ScreenAppWidget(),
        ),
      ),
    );
  }
}

class ScreenAppWidget extends StatelessWidget {
  const ScreenAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.amber,
        child: Center(
          child: TextButton(
            child: const Text('click me.'),
            onPressed: () {
              toast('Hello world!', context: context);
            },
          ),
        ),
      ),
    );
  }
}
