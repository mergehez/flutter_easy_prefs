part of '../easy_prefs.dart';

/// String list with notification on value changes
class NotifiableStringList implements List<String> {
  final List<String> _values;

  final void Function(List<String> innerList)? onValueChanged;

  const NotifiableStringList(this._values, [this.onValueChanged]);

  void _notifyListener() {
    onValueChanged?.call(_values);
  }

  void toggleValue(String value) {
    final hasIt = contains(value);

    if (hasIt) {
      remove(value);
    } else {
      add(value);
    }
  }

  @override
  int get length => _values.length;

  @override
  set length(int newLength) {
    if (newLength != length) {
      _values.length = newLength;
      _notifyListener();
    }
  }

  @override
  set first(String value) {
    _values.first = value;
    _notifyListener();
  }

  @override
  set last(String value) {
    _values.last = value;
    _notifyListener();
  }

  @override
  void add(String element) {
    _values.add(element);
    _notifyListener();
  }

  @override
  void addAll(Iterable<String> iterable) {
    for (String element in iterable) {
      _values.add(element);
    }
    _notifyListener();
  }

  @override
  void clear() {
    if (length > 0) {
      _values.clear();
      _notifyListener();
    }
  }

  @override
  bool remove(Object? element) {
    bool result = _values.remove(element);
    if (result) _notifyListener();

    return result;
  }

  @override
  void forEach(void Function(String element) action) {
    _values.forEach(action);
    _notifyListener();
  }

  @override
  void retainWhere(bool Function(String element) test) {
    _values.retainWhere(test);
    _notifyListener();
  }

  @override
  void removeWhere(bool Function(String element) test) {
    _values.removeWhere(test);
    _notifyListener();
  }

  @override
  void replaceRange(int start, int end, Iterable<String> newContents) {
    _values.replaceRange(start, end, newContents);
    _notifyListener();
  }

  @override
  void fillRange(int start, int end, [String? fill]) {
    _values.fillRange(start, end, fill);
    _notifyListener();
  }

  @override
  void removeRange(int start, int end) {
    RangeError.checkValidRange(start, end, length, "start", "end");

    _values.removeRange(start, end);
    _notifyListener();
  }

  @override
  void setRange(int start, int end, Iterable<String> iterable, [int skipCount = 0]) {
    _values.setRange(start, end, iterable, skipCount);
    _notifyListener();
  }

  @override
  String removeLast() {
    String last = _values.removeLast();
    _notifyListener();
    return last;
  }

  @override
  String removeAt(int index) {
    String element = _values.removeAt(index);
    _notifyListener();
    return element;
  }

  @override
  void setAll(int index, Iterable<String> iterable) {
    RangeError.checkValidRange(index, index + iterable.length, length, "index", "index + iterable.length");
    _values.setAll(index, iterable);
    _notifyListener();
  }

  @override
  void insert(int index, String element) {
    RangeError.checkValidIndex(index, _values, "index", length);

    _values.insert(index, element);
    _notifyListener();
  }

  @override
  void insertAll(int index, Iterable<String> iterable) {
    _values.insertAll(index, iterable);
    _notifyListener();
  }

  @override
  void shuffle([Random? random]) {
    _values.shuffle(random);
    _notifyListener();
  }

  @override
  void sort([int Function(String a, String b)? compare]) {
    _values.sort(compare);
    _notifyListener();
  }

  @override
  NotifiableStringList operator +(List<String> other) => NotifiableStringList(_values + other, onValueChanged);

  @override
  String operator [](int index) => _values[index];

  @override
  void operator []=(int index, String value) {
    if (_values[index] != value) {
      _values[index] = value;
      _notifyListener();
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is NotifiableStringList && runtimeType == other.runtimeType && _values == other._values);

  @override
  int get hashCode => _values.join(",").hashCode;

  @override
  bool any(bool Function(String element) test) => _values.any(test);

  @override
  Map<int, String> asMap() => _values.asMap();

  @override
  List<R> cast<R>() => _values.cast<R>();

  @override
  bool contains(Object? element) => _values.contains(element);

  @override
  String elementAt(int index) => _values.elementAt(index);

  @override
  bool every(bool Function(String element) test) => _values.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(String element) toElements) => _values.expand<T>(toElements);

  @override
  String get first => _values.first;

  @override
  String firstWhere(bool Function(String element) test, {String Function()? orElse}) => _values.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, String element) combine) => _values.fold<T>(initialValue, combine);

  @override
  Iterable<String> followedBy(Iterable<String> other) => _values.followedBy(other);

  @override
  Iterable<String> getRange(int start, int end) => _values.getRange(start, end);

  @override
  int indexOf(String element, [int start = 0]) => _values.indexOf(element, start);

  @override
  int indexWhere(bool Function(String element) test, [int start = 0]) => _values.indexWhere(test, start);

  @override
  bool get isEmpty => _values.isEmpty;

  @override
  bool get isNotEmpty => _values.isNotEmpty;

  @override
  Iterator<String> get iterator => _values.iterator;

  @override
  String join([String separator = ""]) => _values.join(separator);

  @override
  String get last => _values.last;

  @override
  int lastIndexOf(String element, [int? start]) => _values.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(String element) test, [int? start]) => _values.lastIndexWhere(test, start);

  @override
  String lastWhere(bool Function(String element) test, {String Function()? orElse}) => _values.lastWhere(test, orElse: orElse);

  @override
  Iterable<T> map<T>(T Function(String e) toElement) => _values.map<T>(toElement);

  @override
  String reduce(String Function(String value, String element) combine) => _values.reduce(combine);

  @override
  Iterable<String> get reversed => _values.reversed;

  @override
  String get single => _values.single;

  @override
  String singleWhere(bool Function(String element) test, {String Function()? orElse}) => _values.singleWhere(test, orElse: orElse);

  @override
  Iterable<String> skip(int count) => _values.skip(count);

  @override
  Iterable<String> skipWhile(bool Function(String value) test) => _values.skipWhile(test);

  @override
  List<String> sublist(int start, [int? end]) => _values.sublist(start, end);

  @override
  Iterable<String> take(int count) => _values.take(count);

  @override
  Iterable<String> takeWhile(bool Function(String value) test) => _values.takeWhile(test);

  @override
  List<String> toList({bool growable = true}) => _values.toList(growable: growable);

  @override
  Set<String> toSet() => _values.toSet();

  @override
  Iterable<String> where(bool Function(String element) test) => _values.where(test);

  @override
  Iterable<T> whereType<T>() => _values.whereType<T>();
}
