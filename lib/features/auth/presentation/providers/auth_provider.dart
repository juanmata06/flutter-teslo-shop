import 'package:flutter_riverpod/legacy.dart';

import 'package:teslo_shop/features/auth/domain/domain_exports.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure_exports.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthStateNotifier, AuthState>((ref) {
  final authRepositoryImpl = AuthRepositoryImpl();
  return AuthStateNotifier(
    authRepository: authRepositoryImpl
  );
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  
  AuthStateNotifier({
    required this.authRepository
  }): super(AuthState());

  Future<void> loginUser (String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('There was an error in the login.');
    }
  }

  Future<void> registerUser (String email, String password, String fullName) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.register(email, password, fullName);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('There was an error in the register.');
    }
  }

  Future<void> checkStatus () async {}

  Future<void> logout ([String? errorMessage]) async {
    //TODO limpiar token
    state = state.copyWith(
      authStatus: AuthStatus.noAuthtenticated, 
      user: null, 
      errorMessage: errorMessage
    );
  }

  void _setLoggedUser(User user) {
    //TODO guardar token en dispositivo
    state = state.copyWith(
      authStatus: AuthStatus.authenticated, 
      user: user, 
      // errorMessage: ''
    );

  }
}

enum AuthStatus { checking, authenticated, noAuthtenticated}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}