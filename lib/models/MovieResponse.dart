import 'package:abatime/models/Movie.dart';

class MovieResponse {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MovieResponse({this.status, this.statusMessage, this.data, this.meta});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? new Meta.fromJson(json['@meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    if (this.meta != null) {
      data['@meta'] = this.meta?.toJson();
    }
    return data;
  }
}

class Data {
  int movieCount;
  int limit;
  int pageNumber;
  List<Movie>? movies;

  Data({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    this.movies,
  });

  static Data fromJson(Map<String, dynamic> json) => Data(
        movieCount: json['movie_count'] as int,
        limit: json['limit'] as int,
        pageNumber: json['page_number'] as int,
        movies: json['movies'] == null
            ? null
            : (json['movies'] as List<dynamic>).map((v) {
                return new Movie.fromJson(v as Map<String, dynamic>);
              }).toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_count'] = this.movieCount;
    data['limit'] = this.limit;
    data['page_number'] = this.pageNumber;
    if (this.movies != null) {
      data['movies'] = this.movies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  num? serverTime;
  String? serverTimezone;
  num? apiVersion;
  String? executionTime;

  Meta(
      {this.serverTime,
      this.serverTimezone,
      this.apiVersion,
      this.executionTime});

  Meta.fromJson(Map<String, dynamic> json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_time'] = this.serverTime;
    data['server_timezone'] = this.serverTimezone;
    data['api_version'] = this.apiVersion;
    data['execution_time'] = this.executionTime;
    return data;
  }
}
