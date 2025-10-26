import 'package:formz/formz.dart';

// Define input validation errors
enum TextError { empty, length }

// Extend FormzInput and provide the input type and error type.
class TextInput extends FormzInput<String, TextError> {
  // Call super.pure to represent an unmodified form input.
  const TextInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextInput.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextError.empty) return 'El campo es requerido';
    if (displayError == TextError.length) return 'Debe tener al menos 3 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextError.empty;
    if (value.trim().length < 3) return TextError.length;
    return null;
  }
}
