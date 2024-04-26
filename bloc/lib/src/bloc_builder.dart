import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocBuilder<E extends Object?, S extends Object?> extends StatefulWidget {
  const BlocBuilder({
    super.key,
    required this.bloc,
    required this.builder,
    this.doBefore,
  });

  final Bloc<E, S> bloc;
  final Widget Function(BuildContext context, S state) builder;
  final void Function()? doBefore;

  @override
  State<BlocBuilder<E, S>> createState() => _BlocBuilderState<E, S>();
}

class _BlocBuilderState<E extends Object?, S extends Object?> extends State<BlocBuilder<E, S>> {
  late S state = widget.bloc.state;
  late StreamSubscription<S> subscription;

  void _handleChanges(S state) {
    if (!mounted) return;

    setState(() {
      this.state = state;
    });
  }

  @override
  void initState() {
    super.initState();

    widget.doBefore?.call();

    subscription = widget.bloc.stream.listen(_handleChanges);
  }

  @override
  void didUpdateWidget(covariant BlocBuilder<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.bloc.stream != widget.bloc.stream) {
      subscription.cancel();
      subscription = widget.bloc.stream.listen(_handleChanges);
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, state);
}
