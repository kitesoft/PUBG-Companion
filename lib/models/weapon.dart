class Weapon {
  final String name;
  final String family;
  final String ammo;
  final int mag;
  final double rate;
  final int damage;
  final int bulletSpeed;
  final double reload;
  final int range;
  final double scopedSpread;
  final bool crateOnly;
  final bool mobile;

  Weapon(
      {this.name,
      this.family,
      this.ammo,
      this.mag,
      this.rate,
      this.damage,
      this.bulletSpeed,
      this.reload,
      this.range,
      this.scopedSpread,
      this.crateOnly,
      this.mobile});

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return new Weapon(
      name: json['name'],
      family: json['family'],
      ammo: json['ammo'],
      mag: json['mag'],
      rate: double.parse(json['rate'].toString()),
      damage: json['damage'],
      bulletSpeed: json['bulletspeed'],
      reload: double.parse(json['reload'].toString()),
      range: json['range'],
      scopedSpread: double.parse(json['scopedspread'].toString()),
      crateOnly: json['crateonly'].toString().toUpperCase() == 'TRUE',
      mobile: json['mobile'].toString().toUpperCase() == 'TRUE',
    );
  }
}
