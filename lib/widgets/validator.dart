class Validator {
  final String errorText;
  Validator({required this.errorText});

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (value == null || value == "") {
      return errorText != "" ? errorText : 'E-mail Id required.';
    } else if (!regex.hasMatch(value)) {
      return errorText != "" ? errorText : 'Invalid E-mail Id';
    } else {
      return null;
    }
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value == "") {
      return errorText != "" ? errorText : 'Password required.';
    } else if (!regex.hasMatch(value)) {
      return errorText != ""
          ? errorText
          : 'Password should be greater than 6 digit.';
    } else {
      return null;
    }
  }

  String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return errorText != "" ? errorText : "Can't be empty";
    } else {
      return null;
    }
  }

  String? optional(String? value) {
    return null;
  }
}
