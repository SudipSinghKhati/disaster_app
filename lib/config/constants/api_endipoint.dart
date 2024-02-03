class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:4000";

  // static const String baseUrl = "http://192.168.101.4:4000";
  // static const String baseUrl = "http://172.26.0.95:4000";

  //===================User Routes =====================================
  static const String signIn = "/users/signIn";
  static const String signUp = "/users/signUp";

  //=======================Newss Routes ================================
  static const String getAllNews = '/news/getAllNews';
  static const String addNews = '/news/addNewss';
  static const String uploadImage = "/news/uploadImage/";
  static const String getMyNews = "/news/getMyNewss";
  static String getNewsById(String newsId) => "/news/$newsId";
  static String updateNews(String newsId) => "/news/getMyNews/$newsId";
  static String deleteNews(String newsId) => "/news/getMyNews/$newsId";
  // static const String imageUrl = "http://10.0.2.2:4000/uploads/";
  // static const String imageUrl = "http://192.168.101.11:4000/uploads/";
}
