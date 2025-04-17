# Dart Result Library

A powerful Result type implementation for Dart that provides a safe and elegant way to handle operations that may fail.

## Overview

This library provides a robust implementation of the Result pattern, allowing you to handle operations that may fail in a type-safe and functional way. The Result type represents either a successful value ([Ok](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L28-31)) or an error ([Error](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L33-36)).

## Features

- Type-safe error handling
- Functional programming pattern support
- Async operation support through `AsyncResult`
- Easy pattern matching with `fold`
- Immutable design
- Comprehensive error handling

## Usage

### Basic Usage

```dart
import 'package:result/result.dart';

// Create a successful result
final okResult = Result.ok(42);

// Create an error result
final errorResult = Result.error(Exception('Something went wrong'));

// Pattern matching with fold
final result = someOperation();
result.fold(
  (value) => print('Success: $value'),
  (error) => print('Error: $error'),
);
```

### Async Operations

```dart
// Using AsyncResult
final asyncResult = someAsyncOperation();

// Handle async result
await asyncResult.fold(
  (value) => print('Success: $value'),
  (error) => print('Error: $error'),
);
```

## API Reference

### Result<T>

- [Result.ok(T value)](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L28-31): Creates a successful result
- [Result.error(Exception exception)](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L33-36): Creates an error result
- [isOk](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L28-31): Returns true if this is an Ok result
- [isError](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L33-36): Returns true if this is an Error result
- [value](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L28-31): Gets the value if this is an Ok result
- [failure](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L33-36): Gets the error if this is an Error result
- [fold<S>(onOk, onError)](https://github.com/tihrasguinho/common/blob/main/result/lib/result.dart#L39-46): Pattern matching function for handling both success and error cases

### AsyncResult<T>

A type alias for `Future<Result<T>>` that simplifies working with asynchronous operations that may fail.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  result: ^0.0.1
```

## License

This package is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.