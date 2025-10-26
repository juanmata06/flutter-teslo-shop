import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:teslo_shop/features/shared/shared_export.dart';
import 'package:teslo_shop/features/auth/auth_export.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GeometricalBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (!context.canPop()) return;
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 40, 
                          color: Colors.white
                        ),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        'Crear cuenta',
                        style: textStyles.titleLarge?.copyWith(color: Colors.white),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 20),
                      child: _RegisterForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerFormState = ref.watch(registerFormProvider);
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Nueva cuenta', style: textStyles.titleMedium)),
          const SizedBox(height: 40),
          //* Nombre
          CustomTextFormField(
            label: 'Nombre completo',
            onChanged: (value) =>
              ref.read(registerFormProvider.notifier).onNameChange(value),
            errorMessage: registerFormState.isFormPosted ? 
              registerFormState.name.errorMessage : 
              null,
          ),
          const SizedBox(height: 30),
          //* Correo
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
              ref.read(registerFormProvider.notifier).onEmailChange(value),
            errorMessage: registerFormState.isFormPosted ? 
              registerFormState.email.errorMessage : 
              null,
          ),
          const SizedBox(height: 30),
          //* Contraseña
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).onPasswordChange(value),
            errorMessage: registerFormState.isFormPosted ? 
              registerFormState.password.errorMessage : 
              null,
          ),
          const SizedBox(height: 30),

          //* Repetir contraseña
          CustomTextFormField(
            label: 'Repita la contraseña',
            obscureText: true,
            onChanged: (value) => ref
              .read(registerFormProvider.notifier)
              .onPasswordConfirmationChange(value),
            errorMessage: registerFormState.isFormPosted ? 
            registerFormState.passwordConfirmation.errorMessage : 
            null,
          ),
          const SizedBox(height: 40),
          //* Botón
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Crear',
              buttonColor: Colors.black,
              onPressed: () =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            ),
          ),

          const SizedBox(height: 30),

          // Enlace a login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                onPressed: () {
                  if (context.canPop()) return context.pop();
                  context.go('/login');
                },
                child: const Text('Ingresa aquí'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
