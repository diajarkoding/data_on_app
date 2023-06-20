class University {
  String country;
  String alphaTwoCode;
  String name;
  dynamic stateProvince;
  List<String> domains;
  List<String> webPages;

  University({
    required this.country,
    required this.alphaTwoCode,
    required this.name,
    this.stateProvince,
    required this.domains,
    required this.webPages,
  });

  factory University.fromJson(Map<String, dynamic> json) => University(
        country: json["country"],
        alphaTwoCode: json["alpha_two_code"],
        name: json["name"],
        stateProvince: json["state-province"],
        domains: List<String>.from(json["domains"].map((x) => x)),
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "alpha_two_code": alphaTwoCode,
        "name": name,
        "state-province": stateProvince,
        "domains": List<dynamic>.from(domains.map((x) => x)),
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
      };
}
