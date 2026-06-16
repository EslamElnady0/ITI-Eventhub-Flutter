import 'dart:async';

import 'app_failure.dart';

class FailureGuard {
  const FailureGuard._();

  static Future<T> run<T>(
    Future<T> Function() action, {
    AppFailure? Function(Object error)? onError,
  }) async {
    try {
      return await action();
    } on AppFailure {
      rethrow;
    } catch (error) {
      final mappedFailure = onError?.call(error);
      if (mappedFailure != null) throw mappedFailure;
      throw AppFailure.fromException(error);
    }
  }

  static Future<void> handle<T>(
    Future<T> Function() action, {
    required FutureOr<void> Function(T value) onSuccess,
    required FutureOr<void> Function(AppFailure failure) onFailure,
    AppFailure? Function(Object error)? onError,
  }) async {
    try {
      final value = await run(action, onError: onError);
      await onSuccess(value);
    } on AppFailure catch (failure) {
      await onFailure(failure);
    }
  }
}
