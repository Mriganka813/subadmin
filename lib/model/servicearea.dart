class ModalArea {
  ModalArea({this.lat, this.long, this.radius});

  double? lat;
  double? long;
  double? radius;

  Map<String, dynamic> toMap() => {
        "center": {"lat": lat, "long": long},
        "radius": radius,
      };
}
