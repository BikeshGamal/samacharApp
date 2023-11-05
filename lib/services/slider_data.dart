import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/slider_model.dart';
class Sliders {
  List<sliderModel> sliders = [];
  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=0ccd783fa02041f0a6af8a46923ba931";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          sliderModel slidermodel = sliderModel(
             element["title"],
             element["description"],
            element["url"],
            element["urlToImage"],
            element["content"],
            element["author"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}