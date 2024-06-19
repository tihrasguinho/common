import 'dart:async';

typedef EventHandler<E extends Object?, S extends Object?> = FutureOr<void> Function(E event, Sender<S> send);

/// Base class for a [Bloc].
///
/// Example:
/// ```dart
/// class CounterBloc extends Bloc<CounterEvent, CounterState> {
///   CounterBloc() : super(CounterState(0)) {
///     on<IncrementEvent>((event, send) => send(CounterState(state.value + 1)));
///     on<DecrementEvent>((event, send) => send(CounterState(state.value - 1)));
///   }
/// }
/// ```
abstract class Bloc<E extends Object?, S extends Object?> extends Stream<S> {
  /// Creates a new [Bloc].
  Bloc(S initialState) {
    _state = initialState;

    _handlers = <_Handler<E, S>>[];
    _controller = StreamController<S>.broadcast();
  }

  late final List<_Handler<E, S>> _handlers;
  late final StreamController<S> _controller;

  late S _state;

  /// The current state.
  S get state => _state;

  /// The stream of states.
  Stream<S> get stream => _controller.stream.asBroadcastStream(
        onListen: (sub) => _controller.add(_state),
        onCancel: (sub) => sub.cancel(),
      );

  /// Dispatches an event.
  void add(E event) {
    assert(() {
      final exists = _handlers.any((handler) => handler.event == event.runtimeType);
      if (!exists) {
        throw Exception('No handler for event $E');
      }
      return true;
    }());

    final handler = _handlers.firstWhere((handler) => handler.event == event.runtimeType);

    handler(event, Sender<S>(_setState));
  }

  /// Registers a handler for an event.
  void when<T extends E>(EventHandler<T, S> handler) {
    assert(() {
      final exists = _handlers.any((handler) => handler.event == T);
      if (exists) {
        throw Exception('Handler for event $T already exists');
      }
      return true;
    }());
    return _handlers.add(_Handler<T, S>(event: T, handler: handler));
  }

  /// Disposes the current bloc.
  void dispose() {
    _controller.close();
  }

  void _setState(S newState) {
    if (newState != _state) {
      _state = newState;
      _controller.add(newState);
    }
  }

  @override
  StreamSubscription<S> listen(void Function(S event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

/// A [Bloc] state sender.
class Sender<S extends Object?> {
  final void Function(S event) send;
  const Sender(this.send);
  void call(S event) => send(event);
}

class _Handler<E extends Object?, S extends Object?> {
  final Type event;
  final EventHandler<E, S> handler;

  const _Handler({required this.event, required this.handler});

  FutureOr<void> call(E event, Sender<S> send) => handler(event, send);
}
