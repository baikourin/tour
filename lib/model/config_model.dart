
class ConfigModel {
  final String searchUrl;

  // 大括号包裹，次构造方法为可选
  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  Map<String, dynamic> toJson() {
    return {searchUrl: searchUrl};
  }
}
