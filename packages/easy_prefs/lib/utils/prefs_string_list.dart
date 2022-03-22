part of easy_prefs;

/// Class to define string list in [PrefsAnnotation]
///
/// Currently it is same as using List<String> but it will change in the future have some handy options
class PrefsStringList {
  final List<String> values;

  const PrefsStringList(this.values);
}
