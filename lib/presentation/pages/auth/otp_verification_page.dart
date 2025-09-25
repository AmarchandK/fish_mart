import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../../../core/config/app_config.dart';
import '../main/main_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(AppConfig.otpLength, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(AppConfig.otpLength, (index) => FocusNode());

  bool _isLoading = false;
  bool _canResend = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  String _getOtpCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  bool _isOtpComplete() {
    return _getOtpCode().length == AppConfig.otpLength;
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < AppConfig.otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (_isOtpComplete()) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    if (!_isOtpComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 2));

      final otpCode = _getOtpCode();

      // For demo purposes, accept any 6-digit OTP
      if (otpCode.length == AppConfig.otpLength) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (context) => const MainPage(),
            ),
          );
        }
      } else {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        // Clear OTP fields
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _startResendTimer();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to resend OTP: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            // Verification Icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.verified_user,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Enter Verification Code',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'We sent a 6-digit code to\n${widget.phoneNumber}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                AppConfig.otpLength,
                (index) => SizedBox(
                  width: 50,
                  height: 60,
                  child: TextFormField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onOtpChanged(value, index),
                    onTap: () {
                      _otpControllers[index].selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: _otpControllers[index].text.length),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Verify Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed:
                    (_isLoading || !_isOtpComplete()) ? null : _verifyOtp,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Verify OTP'),
              ),
            ),

            const SizedBox(height: 24),

            // Resend OTP
            Center(
              child: TextButton(
                onPressed: _canResend ? _resendOtp : null,
                child: Text(
                  _canResend ? 'Resend OTP' : 'Resend OTP in ${_resendTimer}s',
                  style: TextStyle(
                    color: _canResend
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Change Phone Number
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Change Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
