import 'package:santehaggi/services/auth/auth_exceptions.dart';
import 'package:santehaggi/services/auth/auth_provider.dart';
import 'package:santehaggi/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentifaction', () {
    final provider = MockAuthProvider();
    test("Should not be initialized to begin with", () {
      expect(provider.isInitialize, false);
    });

    test("Cannot log out if not initialized", () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test("Should be able to be initialized", () async {
      await provider.initialize();
      expect(
        provider.isInitialize,
        true,
      );
    });

    test("User should be null after initialization", () {
      expect(
        provider.currentUser,
        null,
      );
    });

    test(
      "Should be able to be initialize in less 2 seconds",
      () async {
        await provider.initialize();
        expect(provider.isInitialize, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test("Create should delegate to logIn function", () async {
      final badEmailUser = provider.createUser(
        email: 'kingomam@gmail.com',
        password: 'anyPassword',
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'kingomam@gmail.com',
        password: 'foobar',
      );

      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );

      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test("A logger in user should be able to send email verification",
        () async {
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to log out an log in again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialize => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialize) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialize) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false, email: '');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialize) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialize) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true, email: '');
    _user = newUser;
  }
}
