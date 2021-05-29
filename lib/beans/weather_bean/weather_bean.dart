class WeatherBean {
  String? city;
  double? temp;
  String? icon;

  WeatherBean({this.city, this.temp, this.icon});

  WeatherBean.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    temp = json['temp'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['temp'] = this.temp;
    data['icon'] = this.icon;
    return data;
  }
}
