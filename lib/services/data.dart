import 'package:samachar_app/model/category_model.dart';
List<CategoryModel> getCatagories(){
  List<CategoryModel> category=[];
  CategoryModel categoryModel=new CategoryModel();
  categoryModel.categoryName="Business";
  categoryModel.image="assets/business.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  categoryModel.categoryName="Entertainment";
  categoryModel.image="assets/entertainment.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  categoryModel.categoryName="General";
  categoryModel.image="assets/general.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  categoryModel.categoryName="Health";
  categoryModel.image="assets/health.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  categoryModel.categoryName="Sports";
  categoryModel.image="assets/sport.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  return category;
}