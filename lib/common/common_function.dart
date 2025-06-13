class CommonFunction {
  int? extractIdFromUri(String uriString) {
    final uri = Uri.parse(uriString);

    // Get the value of the 'id' query parameter
    final idString = uri.queryParameters['id'];

    // Try to parse it to an integer, return null if not valid
    return idString != null ? int.tryParse(idString) : null;
  }
}
