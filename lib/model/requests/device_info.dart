class DeviceInfo {
  String? deviceId;
  String? deviceToken;
  String? osType;
  String? osVersion;
  String? appVersion;
  String? make;
  String? model;
  String? ipAddress;
  String? customerId;
  String? customerEmail;

  DeviceInfo(
      {this.customerId,
      this.customerEmail,
      this.deviceId,
      this.deviceToken,
      this.osType,
      this.osVersion,
      this.appVersion,
      this.make,
      this.model,
      this.ipAddress});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    osType = json['osType'];
    osVersion = json['osVersion'];
    appVersion = json['appVersion'];
    make = json['make'];
    model = json['model'];
    ipAddress = json['ipAddress'];
    customerId = json['ipAddcustomerIdress'];
    customerEmail = json['customerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['deviceToken'] = deviceToken;
    data['osType'] = osType;
    data['osVersion'] = osVersion;
    data['appVersion'] = appVersion;
    data['make'] = make;
    data['model'] = model;
    data['ipAddress'] = ipAddress;
    data['customerId'] = customerId;
    data['customerEmail'] = customerEmail;
    return data;
  }
}
