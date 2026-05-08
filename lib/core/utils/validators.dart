import 'package:flutter/material.dart';
import 'package:task_tejas/generated/l10n/app_localizations.dart';

class Validators {
  static String? validateMobile(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.requiredField;
    }

    if (value.length < 10) {
      return AppLocalizations.of(context)!.invalidMobileNumber;
    }

    return null;
  }

  static String? validateOtp(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterOtp;
    }

    if (value.length != 4) {
      return AppLocalizations.of(context)!.invalidOtp;
    }

    return null;
  }

  static String? validateLogin(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.requiredField;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    final mobileRegex = RegExp(r'^\+91[0-9]{10}$');

    if (!emailRegex.hasMatch(value) && !mobileRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmailOrMobile;
    }

    return null;
  }

  static String? validateRequired(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.requiredField;
    }

    return null;
  }

  static String? validateVehicleNumber(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.vehicleNumberRequired;
    }

    final regex = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$');

    if (!regex.hasMatch(value.toUpperCase())) {
      return AppLocalizations.of(context)!.invalidVehicleNumber;
    }

    return null;
  }
}
