extension ObjectNull on dynamic {
  bool get isNull => this == null;
}

extension ObjectNotNull on dynamic {
  bool get isNotNull => this != null;
}

extension ListNullorEmpty on List? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension StringNullorEmpty on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}