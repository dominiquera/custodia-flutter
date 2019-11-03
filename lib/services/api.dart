import 'dart:convert';
import 'dart:developer';

import 'package:custodia/models/driveway_type.dart';
import 'package:custodia/models/home_feature.dart';
import 'package:custodia/models/home_type.dart';
import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/models/management_plan.dart';
import 'package:custodia/models/userDetails.dart';
import 'package:custodia/models/mobility_issue.dart';
import 'package:custodia/models/outdoor_space.dart';
import 'package:custodia/models/score.dart';
import 'package:custodia/models/user.dart';
import 'package:custodia/utils/shared-prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

//import 'network_util.dart';

class APIService {

  static String domainURL = "https://custodia.dominiquera.com/api/v1";
//  static int userId = 3;

  // Return a list of all user roles available in the system
  static fetchRoles() async {
    Response response = await get(
      '$domainURL/roles',
    );

    if (response.statusCode == 200) {
      return HomeType.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load score');
    }
  }

  // Returns a list of all home types available in system
  static Future<List<HomeType>> fetchHomeTypes() async {
    Response response = await get(
      '$domainURL/home_types',
    );
    if (response.statusCode == 200) {
      List<HomeType> homeTypes = [];
      var body = json.decode(response.body);
      for (var x in body) {
        homeTypes.add(HomeType.fromJson(x));
      }
      return homeTypes;
    } else {
      throw Exception('Failed to load home types');
    }
  }

  //  Returns a list of all outdoor spaces available in the system
  static fetchOutdoorSpaces() async {
    Response response = await get(
      '$domainURL/outdoor_spaces',
    );

    if (response.statusCode == 200) {
      List<OutdoorSpace> outdoorSpacesTypes = [];
      var body = json.decode(response.body);
      for (var x in body) {
        outdoorSpacesTypes.add(OutdoorSpace.fromJson(x));
      }
      return outdoorSpacesTypes;
    } else {
      throw Exception('Failed to load outdoor spaces');
    }
  }

  //  Returns a list of all home features available in the system
  static fetchHomeFeatures() async {
    Response response = await get(
      '$domainURL/home_features',
    );

    if (response.statusCode == 200) {
      List<HomeFeature> homeFeatures = [];
      var body = json.decode(response.body);
      for (var x in body) {
        homeFeatures.add(HomeFeature.fromJson(x));
      }
      return homeFeatures;
    } else {
      throw Exception('Failed to load home features');
    }
  }

  //  Return a list of all driveway types available in the system
  static fetchDrivewayTypes() async {
    Response response = await get(
      '$domainURL/driveway_types',
    );

    if (response.statusCode == 200) {
      List<DrivewayType> driveways = [];
      var body = json.decode(response.body);
      for (var x in body) {
        driveways.add(DrivewayType.fromJson(x));
      }
      return driveways;

    } else {
      throw Exception('Failed to load driveway types');
    }
  }

  static setDrivewayTypes() async {
    Response response = await post(
      '$domainURL/driveway_types',
        body: {"driveways": [1, 2]}
    );

    if (response.statusCode == 200) {
      return DrivewayType.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load driveway types');
    }
  }

  //  Return a list of all mobility issue types available in the system
  static fetchMobilityIssues() async {
    Response response = await get(
      '$domainURL/mobility_issues',
    );

    if (response.statusCode == 200) {
      List<MobilityIssue> mobilityIssues = [];
      var body = json.decode(response.body);
      for (var x in body) {
        mobilityIssues.add(MobilityIssue.fromJson(x));
      }
      return mobilityIssues;
    } else {
      throw Exception('Failed to load mobility issues');
    }
  }

  //  Return a list of all mobility issue types available in the system
  static fetchManagementPlans() async {
    Response response = await get(
      '$domainURL/management_plans',
    );

    if (response.statusCode == 200) {
      List<ManagementPlan> managegementPlans = [];
      var body = json.decode(response.body);
      for (var x in body) {
        managegementPlans.add(ManagementPlan.fromJson(x));
      }
      return managegementPlans;
    } else {
      throw Exception('Failed to fetchManagementPlans');
    }
  }

  //  Returns the current score for a given user id
  static Future<Score> fetchScore(int userId) async {
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
  static Future<List<MaintenanceItem>> fetchIgnoredMaintenanceItems(int userId) async {
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

  //  Returns the user details
  static Future<UserDetails> fetchUserDetails(int userId) async {
    Response response = await get('$domainURL/users/$userId/details');


    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return UserDetails.fromJson(body);
    } else {
      log(json.decode(response.body));
      throw Exception('Failed to fetchUserDetails');
    }
  }

  //  Returns the top 3 maintenance items due today for given user
  static Future<List<MaintenanceItem>> fetchTop3Items(int userId) async {
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
  static Future<List<MaintenanceItem>> fetchTop3ItemsForSection(int userId, int section) async {
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

  static Future<void> signInWithGoogleId(FirebaseUser user, Function onSuccess, Function onFail) async {
    Response response = await post(
        '$domainURL/auth',
        body: {"gauth": user.uid }
    );

    if (response.statusCode == 200) {

      var jsonBody = json.decode(response.body);
      SharedPrefsService.setCurrentUserId(jsonBody["id"]);

      onSuccess();
    }
    if (response.statusCode == 404) {
      onFail(user);
    }
  }

  static Future<void> signInWithPhoneNumber(FirebaseUser user, Function onSuccess, Function onFail) async {
    Response response = await post(
        '$domainURL/auth',
        body: {"phone": user.phoneNumber }
    );

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      SharedPrefsService.setCurrentUserId(jsonBody["id"]);

      onSuccess();
    }
    if (response.statusCode == 404) {
      onFail(user);
    }
  }

  //  Create new User
  static Future<void> createUser(
      String googleAuthId,
      String token,
      String name,
      String email,
      String homeType,
      List<int> outdoorSpaces,
      List<int> features,
      List<int> driveways,
      List<int> mobilityIssues,
      List<int> managementPlans,
      String phone,
      String address,
      String zipCode,
      Function onSuccess,
      Function onFail
      ) async {

    String body = json.encode({
      "google_auth_id": googleAuthId,
      "name": name,
      "email": email,
      "home_type": homeType,
      "outdoor_spaces": outdoorSpaces,
      "features": features,
      "driveways": driveways,
      "mobility_issues": mobilityIssues,
      "management_plans" : managementPlans,
      "phone": phone,
      "address": address,
      "zip": zipCode,
      "firebase_registration_token": token,
    });


    Response response = await post(
      '$domainURL/users',
      body: body,
      headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200) {
      onSuccess();
    }

    if (response.statusCode == 400) {
      log(response.body);
      onFail();
    }
  }

  //  Update user's current score
  static Future<Response> updateUserScore(String score) {
    return post(
        '$domainURL/users/{user}/score',
        body: {"score": score}
    );
  }

  static Future<void> ignoreMaintenanceItem(int userId, int itemId, Function onSuccess, Function onFail) async {
    Response response = await post(
        '$domainURL/users/$userId/maintenance_item/$itemId/ignored'
    );

    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onFail();
    }
  }

  static Future<void> markDoneMaintenanceItem(int userId, int itemId, Function onSuccess, Function onFail) async {
    Response response = await post(
        '$domainURL/users/$userId/maintenance_item/$itemId/done'
    );

    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onFail();
    }
  }
}