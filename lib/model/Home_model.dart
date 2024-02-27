import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class newsCenter with ChangeNotifier {
  List _allNews = [];
  List get allNews => _allNews;
  bool isLoading = true;
  bool isLoadingdata = true;
  List _breckingNews = [];
  List get breckingNews => _breckingNews;
  void setNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey={Api Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // print(response.body);
    _breckingNews = data["articles"] as List;
    isLoading = false;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void BusinessNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey={APIkey}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void EntertainmentNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey={API Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void GeneralNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey={API Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void HealthNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey={API key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void SportNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=sport&apiKey={API Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void ScienceNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey={API Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }

  void TechnologyNews() async {
    isLoadingdata = true;
    notifyListeners();
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey={API Key}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    _allNews = data["articles"] as List;
    notifyListeners();
    isLoadingdata = false;
    notifyListeners();
  }
}
