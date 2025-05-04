class ApiService {
  // Пример заглушки API
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Данные загружены!';
  }
}
