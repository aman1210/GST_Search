enum TaxPayerType { regular, composition }
enum Status { active, inactive }
enum BusinessType { manufacturer, trader, serviceProvider }

class GSTProfile {
  final String id;
  final String name;
  final Status status;
  final String address;
  final TaxPayerType taxPayerType;
  final BusinessType businessType;
  final String dateOfRegistration;

  const GSTProfile(
      {required this.id,
      required this.name,
      required this.status,
      required this.address,
      required this.taxPayerType,
      required this.businessType,
      required this.dateOfRegistration});
}
