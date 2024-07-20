import 'dart:convert';
import 'package:read_from_file/models/gender_model.dart';
import 'package:http/http.dart' as http;

class GenderService {
  Future<GenderModel> fetchGenderData(String fullName) async {
    final response =
        await http.get(Uri.parse('https://api.genderize.io?name=$fullName'));
    if (response.statusCode == 200) {
      return GenderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load gender');
    }
  }
}
