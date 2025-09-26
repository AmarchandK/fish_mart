import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth/login_with_phone.dart';
import '../../../domain/usecases/auth/verify_otp.dart';
import '../../../domain/usecases/auth/get_current_user.dart';
import '../../../domain/usecases/auth/logout.dart';
import '../../../domain/usecases/auth/is_logged_in.dart';
import '../../../core/usecase/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithPhone loginWithPhone;
  final VerifyOtp verifyOtp;
  final GetCurrentUser getCurrentUser;
  final Logout logout;
  final IsLoggedIn isLoggedIn;

  AuthBloc({
    required this.loginWithPhone,
    required this.verifyOtp,
    required this.getCurrentUser,
    required this.logout,
    required this.isLoggedIn,
  }) : super(const AuthInitial()) {
    on<AuthLoginWithPhoneRequested>(_onLoginWithPhoneRequested);
    on<AuthVerifyOtpRequested>(_onVerifyOtpRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
  }

  Future<void> _onLoginWithPhoneRequested(
    AuthLoginWithPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final sessionId = await loginWithPhone(
        LoginWithPhoneParams(phoneNumber: event.phoneNumber),
      );

      emit(AuthOtpSent(
        sessionId: sessionId,
        phoneNumber: event.phoneNumber,
      ));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(
    AuthVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await verifyOtp(
        VerifyOtpParams(
          phoneNumber: event.phoneNumber,
          otp: event.otp,
        ),
      );

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await logout(NoParams());
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final loggedIn = await isLoggedIn(NoParams());
      if (loggedIn) {
        final user = await getCurrentUser(NoParams());
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }
}
