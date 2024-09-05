import 'package:flutter/material.dart';

class FormValidator {
  late String? Function(String?) nameValidator;
  late String? Function(String?) phoneValidator;
  late String? Function(String?) emailValidator;
  late String? Function(String?) passwordValidator;
  FormValidator() {
    nameValidator = nameValidation;
    phoneValidator = phoneValidation;
    emailValidator = emailValidation;
    passwordValidator = passwordValidation;
  }

  String? nameValidation(String? name) {
    if (name != null && name.isNotEmpty) {
      bool flag = true;

      for (String char in name.characters) {
        if (isNumber(char)) {
          flag = false;
        }
      }
      if (!flag) {
        return "Name mustn't contain numbers";
      } else {
        // name is correct, no numbers within
        if (name.startsWith(' ') || name.endsWith(' ')) {
          return "Name mustn't start with space";
        } else {
          return null;
        }
      }
    } else {
      return 'Fill Your Name!';
    }
  }

  String? phoneValidation(String? phone) {
    if (phone != null && phone.isNotEmpty) {
      bool flag = true;

      for (String char in phone.characters) {
        if (!isNumber(char)) {
          flag = false;
        }
      }
      if (!flag) {
        return "Phone Number mustn't contain letters";
      } else {
        // name is correct, no numbers within
        if (phone.startsWith(' ') || phone.endsWith(' ')) {
          return "Phone mustn't start or ends with space";
        } else {
          return null;
        }
      }
    } else {
      return 'Fill Your Phone Number!';
    }
  }

  String? emailValidation(String? email) {
    if (email != null && email.isNotEmpty) {
      if (email.contains('@') && email.endsWith('.com')) {
        return null;
      } else {
        return 'Email Format is not correct';
      }
    } else {
      return 'Fill Your Email!';
    }
  }

  String? passwordValidation(String? password) {
    if (password != null && password.isNotEmpty) {
      bool flag = false;

      for (String char in password.characters) {
        if (!isNumber(char)) {
          flag = true;
        }
      }
      if (!flag) {
        return "Mix Letters with Numbers in Password";
      } else {
        // name is correct, no numbers within
        if (password.startsWith(' ') || password.endsWith(' ')) {
          return "Password mustn't start or ends with space";
        } else {
          if (password.length > 8) {
            return null;
          } else {
            return 'Short length password';
          }
        }
      }
    } else {
      return 'Fill Your Password!';
    }
  }

  bool isNumber(String x) {
    return double.tryParse(x) != null;
  }
}
