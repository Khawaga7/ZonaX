part of 'login_bloc.dart';

/// Base class for all Login screen events.
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Fired whenever the phone number input field changes.
/// Carries the updated [phoneNumber] string.
class PhoneNumberChanged extends LoginEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// Fired whenever the password input field changes.
/// Carries the updated [password] string.
class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

/// Fired when the user taps the password visibility toggle icon.
/// Should toggle [LoginState.isPasswordVisible].
class TogglePasswordVisibility extends LoginEvent {
  const TogglePasswordVisibility();
}

/// Fired when the user taps the "Sign In" button.
/// Should validate inputs and attempt authentication.
class SignInSubmitted extends LoginEvent {
  const SignInSubmitted();
}

/// Fired when the user taps the "Forgot password?" link.
/// Should navigate to the forgot-password flow.
class ForgotPasswordTapped extends LoginEvent {
  const ForgotPasswordTapped();
}

/// Fired when the user taps the "Create Account" button.
/// Should navigate to the registration screen.
class CreateAccountTapped extends LoginEvent {
  const CreateAccountTapped();
}
