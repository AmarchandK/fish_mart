part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginWithPhoneRequested extends AuthEvent {
  final String phoneNumber;

  const AuthLoginWithPhoneRequested({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class AuthVerifyOtpRequested extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const AuthVerifyOtpRequested({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [phoneNumber, otp];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}
