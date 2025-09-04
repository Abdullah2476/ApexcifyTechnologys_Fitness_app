class Validators {
  static String? nameValidator(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Name is required";
    }

    // only letters and spaces allowed (no numbers/symbols)
    final regex = RegExp(r"^[a-zA-Z\s]+$");
    if (!regex.hasMatch(name)) {
      return "Name can only contain letters";
    }

    if (name.trim().length < 2) {
      return "Name must be at least 2 characters";
    }

    return null; // ✅ valid name
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? dobValidator(DateTime? dob) {
    if (dob == null) {
      return "Please select your date of birth";
    }

    final today = DateTime.now();
    final age =
        today.year -
        dob.year -
        ((today.month < dob.month ||
                (today.month == dob.month && today.day < dob.day))
            ? 1
            : 0);

    if (age < 13) {
      return "You must be at least 13 years old";
    }

    if (age > 120) {
      return "Please enter a valid date of birth";
    }

    return null;
  }

  static String? stepsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter steps";
    }
    final number = int.tryParse(value);
    if (number == null) {
      return "Steps must be a number";
    }
    if (number < 0) {
      return "Steps cannot be negative";
    }
    return null;
  }
}
