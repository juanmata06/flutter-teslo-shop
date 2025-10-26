import 'package:flutter_riverpod/legacy.dart';
import 'package:formz/formz.dart';

import 'package:teslo_shop/features/shared/shared_export.dart';

//* 3 - StateNotifierProvider - how the provider is consumed:
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

//* 2 - Notifier implementation:
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail, 
      isValid: Formz.validate([newEmail, state.password])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.password])
    );
  }

  onFormSubmit() {
    _markAllFieldsAsTouched();

    if (!state.isValid) return;

    print(state);
  }

  _markAllFieldsAsTouched() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password])
    );
  }
}

//* 1 - Provider state:
class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
      LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
    ''';
  }
}


