import 'dart:convert';
import '../model/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news=[];
  Future<void> getNews() async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2023-10-05&sortBy=publishedAt&apiKey=0ccd783fa02041f0a6af8a46923ba931";
  var response=await http.get(Uri.parse(url));
  var jsonData=jsonDecode(response.body);
  if(jsonData['status']=='ok')
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null)
          {
            ArticleModel articleModel=ArticleModel(
                element["author"],
                element["title"],
                element["description"],
                element["url"],
                element["urlToImage"],
                element["content"]
            );
            news.add(articleModel);
          }
      });
    }
  }
}