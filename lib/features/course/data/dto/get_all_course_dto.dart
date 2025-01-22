import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_api_model.dart';

part 'get_all_course_dto.g.dart';

@JsonSerializable()
class GetAllCourseDto {
  final bool success;
  final int count;
  final List<CourseApiModel> data;

  GetAllCourseDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllCourseDtoToJson(this);

  factory GetAllCourseDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllCourseDtoFromJson(json);
}
