import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth/login_with_phone.dart';
import '../../../domain/usecases/auth/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithPhone loginWithPhone;
  final VerifyOtp verifyOtp;

  AuthBloc({
    required this.loginWithPhone,
    required this.verifyOtp,
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

    final result = await loginWithPhone(
      LoginWithPhoneParams(phoneNumber: event.phoneNumber),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (sessionId) => emit(AuthOtpSent(
        sessionId: sessionId,
        phoneNumber: event.phoneNumber,
      )),
    );
  }

  Future<void> _onVerifyOtpRequested(
    AuthVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await verifyOtp(
      VerifyOtpParams(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    // Implement logout logic here
    emit(const AuthUnauthenticated());
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Implement check auth status logic here
    emit(const AuthUnauthenticated());
  }
}
