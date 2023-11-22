import 'BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> recentBooks() {
    return BaseNetwork.get("recent");
  }

  Future<Map<String, dynamic>> searchBooks(String Pencarian) {
    return BaseNetwork.get("search/$Pencarian");
  }

  Future<Map<String, dynamic>> detailsbook(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("books/$id");
  }
}
