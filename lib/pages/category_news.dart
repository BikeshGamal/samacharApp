import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samachar_app/model/show_category.dart';
import 'package:samachar_app/services/show_category_news.dart';
import 'category_view.dart';
class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}
class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getNews();
  }
  getNews() async {
    showCategoryNews ShowCategoryNews = showCategoryNews();
    await ShowCategoryNews.getCategoryNews(widget.name.toLowerCase());
    categories = ShowCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(widget.name,
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: GestureDetector(
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                        categories[index].url!,
                        categories[index].author!,
                        categories[index].title!,
                      categories[index].description!,
                        );
                  }),
            ),
          ),
        ));
  }
}
class ShowCategory extends StatelessWidget {
  String image, desc, title,url;
  ShowCategory(this.image, this.title, this.desc,this.url);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SliderView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10,),
            Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            ),
            SizedBox(height: 10,),
            Text(desc),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
