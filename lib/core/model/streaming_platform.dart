class StreamingPlatform {
  final String name;
  final String type;
  final String logoUrl;
  final String logoAsset;
  final String? deepLink;

  StreamingPlatform({
    required this.name,
    required this.type,
    required this.logoUrl,
    required this. logoAsset,
    this.deepLink
  });

  Map<String, dynamic> toJson() {
  return {
    'name': name,
    'type': type,
    'logoUrl': logoUrl,
    'logoAsset': logoAsset,
    'deepLink': deepLink,
    };
  }

  factory StreamingPlatform.fromJson(Map<String, dynamic> json) {
    final String nameValue = json['name'] ?? 'Nome Indisponível';
    final String typeValue = json['type'] ?? 'Streaming';
    final String logoUrl = json['logoUrl'];
    final logoAssetValue = json['logoAsset'] ?? _getLogoAssetPath(nameValue);
    final String? deepLinkValue = json['deepLink'];

    return StreamingPlatform(
      name: nameValue, 
      type: typeValue, 
      logoUrl: logoUrl,
      logoAsset: logoAssetValue,
      deepLink: deepLinkValue,
    );
  }
    static String _getLogoAssetPath(String platformName) {
    final sanitizedName = platformName.toLowerCase().replaceAll(' ', '_').replaceAll('+', '_plus');
    return 'assets/images/${sanitizedName}_logo.png';
  }
}