import 'dart:convert';

import 'package:mobile_d2_admin/constants/app_constants.dart';

class DataAdministrationApi {
  final String instanceUrl;
  const DataAdministrationApi({required this.instanceUrl});

  static Future<Map<String, String>> getInstanceInfo() async {
    
    final response = await d2repository.httpClient.get('system/info.json');

    if (response.statusCode == 200) {
      final data = response.body;
      return {
        'version': data['version'],
        'lastAnalytics': data['lastAnalyticsTableSuccess'],
        'runTime': data['lastAnalyticsTableRuntime']
      };
    } else {
      throw Exception('Failed to get Dhis2 instance');
    }
  }

  static Future<String> performMaintenance(dynamic data) async {
    final response = await d2repository.httpClient.post('maintenance', data);

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Failed to perform maintainance');
    }
  }

  static Stream<Map<String, dynamic>> generateTables(dynamic data) async* {
    final response = await d2repository.httpClient.post('resourceTables', data);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final url = jsonResponse['url'] as String;

      yield* recursiveGetStream(url);
    } else {
      throw Exception('Failed to make generate Tabkes');
    }
  }

  static Stream<Map<String, dynamic>> runAnalytics(dynamic data) async* {
    final response =
        await d2repository.httpClient.post('resourceTables/analytics', data);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final url = jsonResponse['url'] as String;

      yield* recursiveGetStream(url);
    } else {
      throw Exception('Failed to make generate Tables');
    }
  }

  static Stream<Map<String, dynamic>> recursiveGetStream(String url) async* {
    final response = await d2repository.httpClient.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final completed = jsonResponse['completed'] as bool;

      yield jsonResponse;

      if (!completed) {
        final newUrl = jsonResponse['relativeNotifierEndpoint'] as String;
        recursiveGetStream(newUrl);
      }
    } else {
      throw Exception('Failed to make get request');
    }
  }
}
