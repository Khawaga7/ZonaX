part of 'login_bloc.dart';

/// Represents the status of the sign-in network request.
enum LoginStatus {
  /// Idle — no request in flight.
  initial,

  /// A sign-in request is currently loading.
  loading,

  /// The sign-in request succeeded.
  success,

  /// The sign-in request failed.
  failure,
}

/// Holds all UI state for the Login screen.
class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  /// Current value of the phone number field.
  final String phoneNumber;

  /// Current value of the password field.
  final String password;

  /// Whether the password characters are visible.
  final bool isPasswordVisible;

  /// Current status of the authentication request.
  final LoginStatus status;

  /// Non-null when [status] is [LoginStatus.failure]; contains the error text.
  final String? errorMessage;

  /// Returns true when the sign-in button should be enabled.
  /// Should be derived from [phoneNumber] and [password] validity.
  bool get isFormValid => phoneNumber.isNotEmpty && password.isNotEmpty;

  /// Returns true while the loading indicator should be shown.
  bool get isLoading => status == LoginStatus.loading;

  /// Creates a copy of this state with the provided fields replaced.
  LoginState copyWith({
    String? phoneNumber,
    String? password,
    bool? isPasswordVisible,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    password,
    isPasswordVisible,
    status,
    errorMessage,
  ];
}
