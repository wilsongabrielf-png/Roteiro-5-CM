import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String key = 'tasks';

  Future<void> saveTasks(List<String> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, tasks);
  }

  Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}