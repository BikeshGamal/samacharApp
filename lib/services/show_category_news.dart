import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/show_category.dart';
class showCategoryNews {
  List<ShowCategoryModel> categories = [];
  Future<void> getCategoryNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0ccd783fa02041f0a6af8a46923ba931";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            element["title"],
            element["description"],
            element["url"],
            element["urlToImage"],
            element["content"],
            element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}