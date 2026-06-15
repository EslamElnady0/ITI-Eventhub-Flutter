import '../entities/home_category_entity.dart';

class HomeClassificationDto {
  const HomeClassificationDto({this.id = '', this.name = ''});

  final String? id;
  final String? name;

  factory HomeClassificationDto.fromJson(Map<String, dynamic> json) {
    final segment = json['segment'];
    if (segment is! Map) {
      return const HomeClassificationDto();
    }
    return HomeClassificationDto(
      id: segment['id'] is String ? segment['id'] as String : '',
      name: segment['name'] is String ? segment['name'] as String : '',
    );
  }

  HomeCategoryEntity? toEntity() {
    final categoryName = name?.trim() ?? '';
    if (categoryName.isEmpty) return null;

    return HomeCategoryEntity(
      id: id?.trim() ?? '',
      name: categoryName == 'Undefined' ? 'Default' : categoryName,
      apiName: categoryName,
    );
  }
}
