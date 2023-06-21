class DriverModel {
  DriverModel({
    this.driverId,
    this.isVerified,
    this.isBanned,
    this.isRejected,
    this.licenseID,
    this.serviceAreaId,
  });

  String? driverId;
  bool? isVerified;
  bool? isBanned;
  bool? isRejected;
  String? licenseID;
  String? serviceAreaId;

  factory DriverModel.fromMap(Map<String, dynamic> json) => DriverModel(
        driverId: json["_id"],
        isVerified: json["isVerified"],
        isBanned: json["isBanned"],
        isRejected: json["isRejected"],
        licenseID: json["licenseNum"],
        serviceAreaId: json["serviceAreaId"],
      );
}
