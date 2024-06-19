import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc.dart';

mixin BlocMixin<T extends StatefulWidget> on State<T> {
  final List<StreamSubscription> _subscriptions = [];

  List<Bloc<dynamic, dynamic>> get blocs;

  void _handleChanges(_) {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    for (final bloc in blocs) {
      _subscriptions.add(bloc.stream.listen(_handleChanges));
    }
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}
