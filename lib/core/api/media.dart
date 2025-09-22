import 'package:dio/dio.dart';
import 'package:movies__series_app/core/model/ratings.dart';
import 'endpoints.dart';
import '../model/actor.dart';
import '../model/filter_data.dart';
import '../model/medium.dart';
import '../model/page.dart';

Future<Page<Medium>> getMediaPage({
  int page = 1,
  FilterData? filterData,
}) async {
  final response = await Dio().get(
    Endpoints.media(),
    queryParameters: {
      'page': page,
      if (filterData != null) ...filterData.toQueryParams(),
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = (response.data as Map<String, dynamic>);
    return Page<Medium>.fromJson(
      jsonResponse,
      (json) => Medium.fromJson(json),
    );
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<Actor>> getMediumCast(int id) async {
  final response = await Dio().get(Endpoints.cast(id: id));

  if (response.statusCode == 200) {
    List jsonResponse = response.data;

    return jsonResponse.map((actor) => Actor.fromJson(actor)).toList();
  } else {
    throw Exception('Failed to load movie cast');
  }
}

Future<List<Medium>> getMediaByIds(List<int> ids) async {
  if (ids.isEmpty) {
    return [];
  }

  final futures = ids.map((id) async {
    try {
      final response = await Dio().get(Endpoints.media());
      if (response.statusCode == 200) {
        return Medium.fromJson(response.data);
      }

      return null;
    } catch (e) {
      return null;
    }
  }).toList();

  final List<Medium?> results = await Future.wait(futures);

  return results.whereType<Medium>().toList();
}

Future<Ratings> getMediumRatings(int id) async {
  final response = await Dio().get(Endpoints.ratings(id: id));

  if (response.statusCode == 200) {
    return Ratings.fromJson(response.data);
  } else {
    throw Exception('Failed to load movie ratings');
  }
}
