import 'package:flutter_riverpod/legacy.dart';
import 'package:formz/formz.dart';

import 'package:teslo_shop/features/auth/auth_export.dart';
import 'package:teslo_shop/features/shared/shared_export.dart';

//* 3 - StateNotifierProvider - how the provider is consumed:
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallBack = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(
    registerUserCallBack: registerUserCallBack
  );
});

//* 2 - Notifier implementation:
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallBack;

  RegisterFormNotifier({
    required this.registerUserCallBack
  }) : super(RegisterFormState());

  onNameChange(String value) {
    final newName = TextInput.dirty(value);
    state = state.copyWith(
      name: newName, 
      isValid: Formz.validate([newName, state.password])
    );
  }

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

  onPasswordConfirmationChange(String value) {
    final newPasswordConfirmation = PasswordConfirmation.dirty(
      value: value,
      originalPassword: state.password.value,
    );

    state = state.copyWith(
      passwordConfirmation: newPasswordConfirmation,
      isValid: Formz.validate([newPasswordConfirmation, state.passwordConfirmation]),
    );
  }

  onFormSubmit() async {
    _markAllFieldsAsTouched();

    if (!state.isValid) return;

    await registerUserCallBack(state.email.value, state.password.value, state.name.value);
  }

  _markAllFieldsAsTouched() {
    final name = TextInput.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordConfirmation = PasswordConfirmation.dirty(
      value: state.passwordConfirmation.value, 
      originalPassword: state.password.value
    );

    state = state.copyWith(
      isFormPosted: true,
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      isValid: Formz.validate([email, password])
    );
  }
}

//* 1 - Provider state:
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final TextInput name;
  final Email email;
  final Password password;
  final PasswordConfirmation passwordConfirmation;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const TextInput.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordConfirmation = const PasswordConfirmation.pure()
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    TextInput? name,
    Email? email,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
    passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
  );

  @override
  String toString() {
    return '''
      registerFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      name: $name
      email: $email
      password: $password
      passwordConfirmation: $passwordConfirmation
    ''';
  }
}