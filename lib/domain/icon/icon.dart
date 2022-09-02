enum Icon {
  plus,
  minus,
}

extension IconExtension on Icon {
  String get name {
    switch (this) {
      case Icon.plus:
        return "assets/icons/plus.png";
      default:
        return "";
    }
  }
}
