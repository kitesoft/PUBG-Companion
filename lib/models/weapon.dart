class Weapon {
  final String name;
  final String family;
  final String ammo;
  final int mag;
  final double rate;
  final int damage;
  final int bulletSpeed;
  final double drag;
  final double reload;
  final int range;
  final double spread;
  final double scoping;
  final bool crateOnly;
  final bool mobile;
  final String fullName;
  final String manufacturer;
  final String country;
  final String countryFull;
  final int year;
  final String wikipediaSummary;
  final String wikipediaLink;

  Weapon(
      {this.name,
      this.family,
      this.ammo,
      this.mag,
      this.rate,
      this.damage,
      this.bulletSpeed,
      this.drag,
      this.reload,
      this.range,
      this.spread,
      this.scoping,
      this.crateOnly,
      this.mobile,
      this.fullName,
      this.manufacturer,
      this.country,
      this.countryFull,
      this.year,
      this.wikipediaSummary,
      this.wikipediaLink});

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return new Weapon(
      name: json['name'],
      family: json['family'],
      ammo: json['ammo'],
      mag: json['mag'],
      rate: double.parse(json['rate'].toString()),
      damage: json['damage'],
      bulletSpeed: json['bulletspeed'],
      drag: json['drag'].toString() != 'None'
          ? double.parse(json['drag'].toString())
          : 0.0,
      reload: double.parse(json['reload'].toString()),
      range: json['range'],
      spread: json['spread'].toString() != 'None'
          ? double.parse(json['spread'].toString())
          : 0.0,
      scoping: json['scoping'].toString() != 'None'
          ? double.parse(json['scoping'].toString())
          : 0.0,
      crateOnly: json['crateonly'].toString().toUpperCase() == 'TRUE',
      mobile: json['mobile'].toString().toUpperCase() == 'TRUE',
      fullName: json['fullname'] ?? null,
      manufacturer: json['manufacturer'] ?? null,
      country: json['country'] ?? null,
      countryFull: json['countryfull'] ?? null,
      year: json['year'] != 'None' ? json['year'] : 0,
      wikipediaSummary: json['wikipediasummary'] == 'None'
          ? 'None'
          : json['wikipediasummary'],
      wikipediaLink:
          json['wikipedialink'] == 'None' ? 'None' : json['wikipedialink'],
    );
  }

  double scopedSpread() {
    return spread * scoping;
  }
}
