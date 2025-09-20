class StreamingPlatform {
  final String name;
  final String type;
  final String logoAsset;
  final String? deepLink;

  StreamingPlatform({
    required this.name,
    required this.type,
    required this.logoAsset,
    this.deepLink
  });

  factory StreamingPlatform.fromJson(Map<String, dynamic> json) {
    final String nameValue = json['name'] ?? 'Nome Indisponível';
    final String typeValue = json['type'] ?? 'Streaming';
    final String logoAssetValue = _getLogoAssetPath(nameValue);
    final String? deepLinkValue = json['deepLink'];

    return StreamingPlatform(
      name: nameValue, 
      type: typeValue, 
      logoAsset: logoAssetValue,
      deepLink: deepLinkValue,
      );
  }
  static String _getLogoAssetPath(String platformName) {
    final sanitizedName = platformName.toLowerCase().replaceAll(' ', '_');
    return 'assets/images/${sanitizedName}_logo.png';
  }
}