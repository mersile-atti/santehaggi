class DatabaseAlreadyOpenExcepton implements Exception {
  final String message;

  const DatabaseAlreadyOpenExcepton(this.message);

  @override
  String toString() => 'DatabaseAlreadyOpenExcepton: $message';
}

class DatabaseIsNotOpen implements Exception {
  const DatabaseIsNotOpen();

  @override
  String toString() => 'DatabaseIsNotOpen';
}

class UnableToGetDocumentsDirectory implements Exception {}

class CouldNotDeleteUser implements Exception {}

class UserAlreadyExists implements Exception {}

class CouldNotFoundUser implements Exception {}

class CouldNotDeleteNote implements Exception {}

class CouldNotFoundNote implements Exception {}

class CouldNotUpdatedNote implements Exception {}
