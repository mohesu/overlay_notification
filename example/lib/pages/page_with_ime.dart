import 'package:flutter/material.dart';
import 'package:overlay_notification/overlay_notification.dart';

class PageWithIme extends StatelessWidget {
  const PageWithIme({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('toast with ime')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
              child: const Text('show toast'),
              onPressed: () {
                toast('message');
              }),
          const TextField(autofocus: true)
        ],
      ),
    );
  }
}
