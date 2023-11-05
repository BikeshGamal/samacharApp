import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:samachar_app/model/slider_model.dart';
import 'package:samachar_app/pages/article_view.dart';
import 'package:samachar_app/pages/category_news.dart';
import 'package:samachar_app/pages/slider_view.dart';
import 'package:samachar_app/services/data.dart';
import 'package:samachar_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/article_model.dart';
import '../model/category_model.dart';
import '../services/news.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles=[];
  int activeIndex=0;
  bool _loading=true;
  @override
  void initState() {
    categories = getCatagories();
    getSlider();
    getNews();
    super.initState();
  }
getNews() async{
    News newsclass=News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
_loading=false;
    });
}
  getSlider() async {
    Sliders slider= Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Samachar",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            Text(
              "App",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24
              ),
            )
          ],
        ),
        elevation: 0,
      ),
      body: _loading?Center(child: CircularProgressIndicator()) :SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        image: categories[index].image,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Breaking News",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ]),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SliderView(blogUrl: sliders[activeIndex].description!)));
                },
                child: CarouselSlider.builder(
                    itemCount:5,
                    itemBuilder: (context, index, realIndex) {
                      String? res = sliders[index].url;
                      String? res1 = sliders[index].title;
                      return buildImage(res!, index, res1!);
                    },
                    options: CarouselOptions(height: 250,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged:(index,reason){
                      setState(() {
                          activeIndex=index;
                      });
                        }
                    )),
              ),
              SizedBox(height: 30,),
              Center(child: buildIndicator()),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Trending News",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    )
                    ]),
              ),
              SizedBox(height: 10,),
             Container(
               child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: articles.length,itemBuilder: (context,index){
                 return BlogTile(articles[index].urlToImage!, articles[index].title!, articles[index].description!,articles[index].url!);
               }),
             )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) => Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:CachedNetworkImage(
              imageUrl: image,
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top:130),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
            child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            )
]),
      );
  Widget buildIndicator()=>AnimatedSmoothIndicator(activeIndex: activeIndex,
    count: 5,
  effect: SlideEffect(dotWidth: 10,dotHeight: 10,activeDotColor: Colors.blue),
  );
}
class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.image, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryNews(name:categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:
                  Image.asset(image, width: 120, height: 70, fit: BoxFit.cover),
            ),
            Container(
              width: 120,
              height: 70,
              color: Colors.black38,
              child: Center(
                  child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  String imageUrl,title,desc,url;
 BlogTile(
     this.imageUrl,
     this.title,
     this.desc,
     this.url
     );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl:imageUrl,height: 100,width:100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 25,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Text(title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Text(desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

