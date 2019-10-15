import 'dart:convert';
import 'dart:io';

import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/models/score.dart';
import 'package:http/http.dart';

class APIService {

  static String domainURL = "https://custodia.dominiquera.com/api/v1";
  static int userId = 4;

  //  Returns the current score for a given user id
  static Future<Score> fetchScore() async {
    Response response = await get(
      '$domainURL/users/$userId/score',
    );

    if (response.statusCode == 200) {
      return Score.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load score');
    }
  }

  //  Returns the list of done maintenance items for a given user id
  static Future<Response> fetchDoneMaintenanceItems() {
    return get(
      '$domainURL/users/{user}/done_maintenance_items',
    );
  }

  //  Returns the list of ignored maintenance items for a given user id
  static Future<List<MaintenanceItem>> fetchIgnoredMaintenanceItems() async {
    Response response = await get('$domainURL/users/$userId/ignored_maintenance_items');
    List<MaintenanceItem> maintenanceItems = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for(var x in body["maintenance_items"]) {
        maintenanceItems.add(MaintenanceItem.fromJson(x));
      }
      return maintenanceItems;
    } else {
      throw Exception('Failed to load ignored maintenance items');
    }
  }

  //  Returns the top 3 maintenance items due today for given user
  static Future<List<MaintenanceItem>> fetchTop3Items() async {
    Response response = await get('$domainURL/users/$userId/top_three_maintenance_items_today');
    List<MaintenanceItem> maintenanceItems = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for(var x in body["maintenance_items"]) {
        maintenanceItems.add(MaintenanceItem.fromJson(x));
      }
      return maintenanceItems;
    } else {
      throw Exception('Failed to load top 3 maintenance items');
    }
  }

  //  Returns the top 3 maintenance items due today for given user and section
  static Future<List<MaintenanceItem>> fetchTop3ItemsForSection(int section) async {
    Response response = await get('$domainURL/users/$userId/section/$section/top_three_maintenance_items_today');
    List<MaintenanceItem> maintenanceItems = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for(var x in body["maintenance_items"]) {
        maintenanceItems.add(MaintenanceItem.fromJson(x));
      }
      return maintenanceItems;
    } else {
      throw Exception('Failed to load top 3 maintenance items for section');
    }
  }

  //  Returns maintenance items belonging to a given section
  static Future<List<MaintenanceItem>> fetchMaintenanceItems(int section) async {
    Response response = await get('$domainURL/sections/$section/maintenance_items');
    List<MaintenanceItem> maintenanceItems = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for(var x in body["maintenance_items"]) {
        maintenanceItems.add(MaintenanceItem.fromJson(x));
      }
      return maintenanceItems;
    } else {
      throw Exception('Failed to load maintenanceItems for section');
    }
  }

  //  Create new User
  static Future<Response> createUser(String name, String email, String role) {
    return post(
      '$domainURL/users',
      body: {"name": name, "email": email, "role": role}
//      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
  }

  //  Update user's current score
  static Future<Response> updateUserScore(String score) {
    return post(
        '$domainURL/users/{user}/score',
        body: {"score": score}
//      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
  }
}