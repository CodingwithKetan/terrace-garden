/// Expected, recoverable failures surfaced to the UI.
///
/// Unexpected programming errors are not modelled here; they are caught at
/// boundaries, logged, and mapped to [UnexpectedFailure].
sealed class AppFailure implements Exception {
  const AppFailure([this.cause]);

  /// The underlying error, kept for logging only (never shown to users).
  final Object? cause;
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.cause]);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(this.field, [super.cause]);

  /// Identifies the invalid input so the UI can attach a message to it.
  final String field;
}

final class StorageFailure extends AppFailure {
  const StorageFailure([super.cause]);
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure({required this.permanentlyDenied, Object? cause})
    : super(cause);

  /// When true the UI should offer "Open settings" instead of asking again.
  final bool permanentlyDenied;
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure([super.cause]);
}
