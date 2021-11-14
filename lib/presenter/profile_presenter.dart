import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:gst_search/model/gst_profile.dart';
import 'package:gst_search/model/gst_profile_data_mock.dart';

class ProfilePresenter extends ChangeNotifier {
  GSTProfile? loadedProfile;

  Future<GSTProfile?> fetchProfile(String id) async {
    try {
      if (kReleaseMode) {
        Uri url = Uri.parse('https://SomeApi.com/id');
        var response = await http.get(url);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        GSTProfile loadedProfile = GSTProfile(
            id: extractedData['id'],
            name: extractedData['name'],
            status:
                extractedData['status'] == 0 ? Status.active : Status.inactive,
            address: extractedData['address'],
            taxPayerType: extractedData['taxPayerType'] == 0
                ? TaxPayerType.regular
                : TaxPayerType.composition,
            businessType: extractedData['businessType'] == 0
                ? BusinessType.manufacturer
                : extractedData['businessType'] == 1
                    ? BusinessType.trader
                    : BusinessType.serviceProvider,
            dateOfRegistration: extractedData['dateOfRegistration']);

        return loadedProfile;
      } else {
        var response =
            await Future.delayed(const Duration(milliseconds: 1000), () {
          return profiles;
        });
        return response.firstWhereOrNull(
          (element) => element.id == id,
        );
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<GSTProfile?> getProfile(String id) async {
    GSTProfile? _profile = await fetchProfile(id);
    return _profile;
  }
}
