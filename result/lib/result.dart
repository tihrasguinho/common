library;

typedef AsyncResult<T> = Future<Result<T>>;

/// A Result is a type that represents the result of an operation which may or may
/// not have succeeded. It is useful for representing the result of operations that
/// may throw exceptions or produce a null result.
///
/// A Result is one of two types: [Ok] or [Error]. [Ok] represents the successful
/// result of an operation and contains a value. [Error] represents the failed
/// result of an operation and contains an exception.
///
/// The [isOk] and [isError] properties allow you to check if a [Result] is an
/// [Ok] or an [Error]. The [value] property allows you to get the value of an
/// [Ok] result, and the [failure] property allows you to get the exception of an
/// [Error] result.
///
/// The [fold] method allows you to use a [Result] without having to manually check
/// which type of result it is. It takes two functions: one to handle the [Ok]
/// result and one to handle the [Error] result. It calls the appropriate
/// function and returns the result.
sealed class Result<T> {
  const Result();
  const factory Result.ok(T value) = Ok<T>._;
  const factory Result.error(Exception exception) = Error<T>._;
  bool get isOk => this is Ok<T>;
  bool get isError => this is Error<T>;
  T get value => (this as Ok<T>)._value;
  Exception get failure => (this as Error<T>)._failure;
  S fold<S>(S Function(T success) onOk, S Function(Exception failure) onError) {
    return switch (this) {
      Ok<T>() => onOk(value),
      Error<T>() => onError(failure),
    };
  }
}

final class Ok<T> extends Result<T> {
  final T _value;
  const Ok._(this._value);
}

final class Error<T> extends Result<T> {
  final Exception _failure;
  const Error._(this._failure);
}
