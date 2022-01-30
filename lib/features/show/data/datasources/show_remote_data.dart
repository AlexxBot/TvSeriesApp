import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/global/url_constants.dart';
import 'package:tvseries_app/core/network/headers.dart';
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/injections.dart';

abstract class ShowRemoteData {
  Future<List<ShowItem>> search(ShowFilter showFilter);
  Future<ShowItem> getShow(String id);
  Future<List<Episode>> getEpisodes(String id);
}

class ShowRemoteDataImple implements ShowRemoteData {
  late final http.Client client;

  ShowRemoteDataImple({required this.client});

  @override
  Future<List<ShowItem>> search(ShowFilter showFilter) async {
    final uri = Uri.parse(
        '${sl<NetworkInfo>().url}/search/$shows?q=${showFilter.name}');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final listJson = jsonDecode(response.body);
      final list =
          listJson.map<ShowItem>((show) => ShowItem.fromJson(show)).toList();
      return list;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }

  @override
  Future<ShowItem> getShow(String id) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/$shows/$id');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final showJson = jsonDecode(response.body);
      final show = ShowItem.fromJsonItem(showJson);
      return show;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }

  @override
  Future<List<Episode>> getEpisodes(String id) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/$shows/$id/episodes');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final listJson = jsonDecode(response.body);
      final list =
          listJson.map<Episode>((show) => Episode.fromJson(show)).toList();
      return list;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }
}
