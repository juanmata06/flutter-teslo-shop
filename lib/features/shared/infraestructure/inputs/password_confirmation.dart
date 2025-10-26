import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordConfirmationError { empty, mismatch }

// Extend FormzInput and provide the input type and error type.
class PasswordConfirmation extends FormzInput<String, PasswordConfirmationError> {
  final String originalPassword;

  // Recibe también la contraseña original para poder comparar
  const PasswordConfirmation.pure({this.originalPassword = ''}) : super.pure('');
  const PasswordConfirmation.dirty({required String value, required this.originalPassword}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordConfirmationError.empty) return 'El campo es requerido';
    if (displayError == PasswordConfirmationError.mismatch) return 'Las contraseñas no coinciden';
    return null;
  }

  @override
  PasswordConfirmationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordConfirmationError.empty;
    if (value != originalPassword) return PasswordConfirmationError.mismatch;
    return null;
  }
}
