import 'package:mobile_d2_admin/constants/api_path.dart';
import 'package:mobile_d2_admin/constants/app_constants.dart';

class DataAdministrationApi {
  final String instanceUrl;
  const DataAdministrationApi({required this.instanceUrl});

  static Future<Map<String, String>> getInstanceInfo() async {
    final response = await d2repository.httpClient.get(systemInfo);

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

  static Future performMaintenance(dynamic data) async {
    final response = await d2repository.httpClient.post(maintenance, data);

    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to perform maintainance');
    }
  }

  static Stream<List<dynamic>> generateTables(
      dynamic data) async* {
    final response = await d2repository.httpClient.post(resourceTables, data);

    if (response.statusCode == 200) {
      final jsonResponse = response.body;

      final url =
          jsonResponse['response']['relativeNotifierEndpoint'] as String;

      yield* recursiveGetStream(url);
    } else {
      throw Exception('Failed to generate resource tables');
    }
  }

  static Stream<List<dynamic>> runAnalytics(dynamic data) async* {
    final response =
        await d2repository.httpClient.post(analytics, data);

    if (response.statusCode == 200) {
      final jsonResponse = response.body;
      final url =
          jsonResponse['response']['relativeNotifierEndpoint'] as String;

      yield* recursiveGetStream(url);
    } else {
      throw Exception('Failed to run analytics');
    }
  }

  static Stream<List<dynamic>> recursiveGetStream(
      String url) async* {
    final getUrl = url.replaceAll('/api/', '');

    try {
      final response = await d2repository.httpClient.get(getUrl);

      final List<dynamic> jsonResponse = response.body;
      
      final completed = jsonResponse[0]['completed'] as bool;

      yield jsonResponse;

      if (!completed) {
        yield* recursiveGetStream(getUrl);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
