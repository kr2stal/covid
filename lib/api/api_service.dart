import 'package:covid19_app/api/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://396fcd5228e9.ngrok.io/covid/user";

    final response = await http.post(
        Uri.parse("https://396fcd5228e9.ngrok.io/covid/user"),
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
