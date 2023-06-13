import 'package:hive/hive.dart';

abstract class GenericCache<T extends HiveObject> {
  Box<T>? _box;
  String? _boxName;

  bool get _boxIsClosed => !(_box?.isOpen ?? false);

  Future<void> save(T data) async {
    if (_boxIsClosed) {
      _openBox();
    }

    await _box!.add(data);
  }

  Future<void> put(key, T data) async {
    if (_boxIsClosed) {
      _openBox();
    }

    await _box!.put(key, data);
  }

  Future<T?> get(id, {T? defaultValue}) async {
    if (_boxIsClosed) {
      _openBox();
    }

    return _box!.get(id, defaultValue: defaultValue);
  }

  Future<T?> getOnly() async {
    if (_boxIsClosed) {
      _openBox();
    }

    var items = await getAll();
    return items.isNotEmpty ? items[0] : null;
  }

  Future<T?> getAt(int index) async {
    if (_boxIsClosed) {
      _openBox();
    }

    return _box!.getAt(index);
  }

  Future<List<T>> getAll() async {
    if (_boxIsClosed) {
      _openBox();
    }

    return _box!.values.toList();
  }

  Future<void> delete(key) async {
    if (_boxIsClosed) {
      _openBox();
    }

    await _box!.delete(key);
  }

  Future<void> deleteAll() async {
    if (_boxIsClosed) {
      _openBox();
    }

    await _box!.clear();
  }

  void _openBox() {
    setupHiveBoxName();
    _box = Hive.box<T>(_boxName!);
  }

  void setupHiveBoxName({String? boxName}) => _boxName = boxName;
}
