import 'package:dio/dio.dart';

class Api{
  // here i'll put the basics of my api requests
  final Dio _dio = Dio();
  
  // Get request
  Future<dynamic> getRequest(String url) async{
    // Fetching data from the API
    Response response = await _dio.get(url);
    // Check if the response is successful
    if (response.statusCode == 200) {
      // Get the data from the response and decode it to JSON
      return response.data; // List<dynamic> or Map<String, dynamic>, so it's a dynamic type
    } else {
      // If the response is not successful, throw an exception
      throw Exception(
        'Failed to load data due to status code: ${response.statusCode}',
      );
    }
  }
}