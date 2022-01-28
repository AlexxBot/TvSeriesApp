import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/global/url_constants.dart';
import 'package:tvseries_app/core/network/headers.dart';
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/injections.dart';

abstract class ShowRemoteData {
  Future<List<ShowItem>> search(ShowFilter showFilter);
}

class ShowRemoteDataImple implements ShowRemoteData {
  late final http.Client client;

  ShowRemoteDataImple({required this.client});

  Future<List<ShowItem>> search(ShowFilter showFilter) async {
    //final uri = Uri.parse('${sl<NetworkInfo>().url}/search/$SHOW', );
    final params = showFilter.toJson(showFilter);
    var uri =
        Uri.https(sl<NetworkInfo>().url, '/search/$SHOW', params);
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
}
