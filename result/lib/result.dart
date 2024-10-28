library;

import 'src/result.dart';

export 'src/result.dart';

typedef AsyncResult<S extends Object?, E extends Object?> = Future<Result<S, E>>;
