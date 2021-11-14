import 'package:flutter/material.dart';
import 'package:gst_search/model/gst_profile.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final GSTProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              genField('Name', profile!.name),
              genField('Address', profile!.address),
              genField('Status',
                  profile!.status == Status.active ? "Active" : "Inactive"),
              genField(
                  'Tax Payer Type',
                  profile!.taxPayerType == TaxPayerType.regular
                      ? "Regular"
                      : "Composition"),
              genField(
                  'Bussiness Type',
                  profile!.businessType == BusinessType.manufacturer
                      ? "Manufacturer"
                      : profile!.businessType == BusinessType.trader
                          ? "Trader"
                          : "Service Provider"),
              genField('Date of Registration', profile!.dateOfRegistration),
            ],
          ),
        ),
      ),
    );
  }

  Padding genField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: SizedBox(
              width: 250,
              child: Text(
                '$title: ',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
