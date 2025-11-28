import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;

  const Pagination({this.currentPage, this.perPage, this.total, this.lastPage});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json['current_page'] as int?,
    perPage: json['per_page'] as int?,
    total: json['total'] as int?,
    lastPage: json['last_page'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'per_page': perPage,
    'total': total,
    'last_page': lastPage,
  };

  @override
  List<Object?> get props => [currentPage, perPage, total, lastPage];
}
