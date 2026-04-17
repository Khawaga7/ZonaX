import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zona_x_16_4/features/auth/data/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Manages all business logic for the Login screen.
///
/// Listens to [LoginEvent]s and emits new [LoginState]s in response.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const LoginState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<ForgotPasswordTapped>(_onForgotPasswordTapped);
    on<CreateAccountTapped>(_onCreateAccountTapped);
  }

  final AuthService _authService;

  /// Handles [PhoneNumberChanged] events.
  ///
  /// Should update [LoginState.phoneNumber] with the new value
  /// and optionally clear any existing error message.
  void _onPhoneNumberChanged(
      PhoneNumberChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      errorMessage: null,
      status: LoginStatus.initial,
    ));
  }

  /// Handles [PasswordChanged] events.
  ///
  /// Should update [LoginState.password] with the new value
  /// and optionally clear any existing error message.
  void _onPasswordChanged(
      PasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      password: event.password,
      errorMessage: null,
      status: LoginStatus.initial,
    ));
  }

  /// Handles [TogglePasswordVisibility] events.
  ///
  /// Should flip [LoginState.isPasswordVisible] to its opposite value.
  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  /// Handles [SignInSubmitted] events.
  ///
  /// Should:
  /// 1. Validate the phone number and password fields.
  /// 2. Emit a loading state.
  /// 3. Call the authentication repository / use-case.
  /// 4. Emit a success or failure state based on the result.
  Future<void> _onSignInSubmitted(
      SignInSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    // Validate form
    if (!state.isFormValid) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Please fill all fields',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    // Attempt sign in using phone as email (or adapt if phone-only auth needed)
    final result = await _authService.signIn(state.phoneNumber, state.password);

    if (result == null) {
      // Success
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      // Failure
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: result,
      ));
    }
  }

  /// Handles [ForgotPasswordTapped] events.
  ///
  /// Should trigger navigation to the forgot-password screen.
  /// Navigation can be handled via a BlocListener in the UI layer.
  void _onForgotPasswordTapped(
      ForgotPasswordTapped event,
      Emitter<LoginState> emit,
      ) {
    // TODO: Implement forgot password navigation
  }

  /// Handles [CreateAccountTapped] events.
  ///
  /// Should trigger navigation to the registration / sign-up screen.
  /// Navigation can be handled via a BlocListener in the UI layer.
  void _onCreateAccountTapped(
      CreateAccountTapped event,
      Emitter<LoginState> emit,
      ) {
    // Navigation is handled by BlocListener in the UI layer
  }
}
