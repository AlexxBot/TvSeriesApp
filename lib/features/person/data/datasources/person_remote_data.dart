import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/global/url_constants.dart';
import 'package:tvseries_app/core/network/headers.dart';
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/injections.dart';

abstract class PersonRemoteData {
  Future<List<Person>> search(PersonFilter showFilter);
  Future<Person> getPerson(String id);
  Future<List<ShowItem>> getShows(String id);
}

class PersonRemoteDataImple implements PersonRemoteData {
  late final http.Client client;

  PersonRemoteDataImple({required this.client});

  @override
  Future<List<Person>> search(PersonFilter showFilter) async {
    final uri = Uri.parse(
        '${sl<NetworkInfo>().url}/search/$person?q=${showFilter.name}');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final listJson = jsonDecode(response.body);
      final list =
          listJson.map<Person>((show) => Person.fromJson(show)).toList();
      return list;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }

  @override
  Future<Person> getPerson(String id) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/$person/$id');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final showJson = jsonDecode(response.body);
      final show = Person.fromJson(showJson);
      return show;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }

  @override
  Future<List<ShowItem>> getShows(String id) async {
    final uri = Uri.parse(
        '${sl<NetworkInfo>().url}/$person/$id/castcredits?embed=show');
    final response = await client
        .get(uri, headers: sl<Headers>().headers)
        .timeout(const Duration(seconds: timeout),
            onTimeout: () => throw TimeOutException());
    if (response.statusCode == 200) {
      final listJson = jsonDecode(response.body);
      final list = listJson
          .map<ShowItem>((show) => ShowItem.fromJsonCastCredits(show))
          .toList();
      return list;
    } else {
      throw ApiResponseException(statusCode: response.statusCode);
    }
  }
}
