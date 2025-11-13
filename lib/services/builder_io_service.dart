import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/builder_io_config.dart';

class BuilderIOService {
  static const String _baseUrl = 'https://cdn.builder.io/api/v3';

  /// Busca todos os conteúdos do Builder.io
  Future<List<BuilderContent>> getAllContent({
    String? model,
    int limit = 50,
  }) async {
    try {
      final modelName = model ?? builderIoModel;
      final url = Uri.parse(
        '$_baseUrl/content/$modelName?apiKey=$builderIoApiKey&limit=$limit&includeRefs=true',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List?;
        
        if (results != null) {
          return results
              .map((item) => BuilderContent.fromJson(item))
              .toList();
        }
        return [];
      } else {
        throw Exception(
          'Erro ao buscar conteúdo: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao buscar conteúdo do Builder.io: $e');
    }
  }

  /// Busca um conteúdo específico por ID
  Future<BuilderContent?> getContentById(String id) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/content/$builderIoModel/$id?apiKey=$builderIoApiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return BuilderContent.fromJson(data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception(
          'Erro ao buscar conteúdo: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao buscar conteúdo do Builder.io: $e');
    }
  }

  /// Gera URL para visualizar o conteúdo em uma WebView
  String getPreviewUrl(String id) {
    return 'https://builder.io/content/$id?apiKey=$builderIoApiKey';
  }
}

class BuilderContent {
  final String id;
  final String name;
  final Map<String, dynamic>? data;
  final String? published;
  final String? lastUpdated;
  final Map<String, dynamic>? meta;

  BuilderContent({
    required this.id,
    required this.name,
    this.data,
    this.published,
    this.lastUpdated,
    this.meta,
  });

  factory BuilderContent.fromJson(Map<String, dynamic> json) {
    return BuilderContent(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 
            json['data']?['title'] as String? ?? 
            'Sem nome',
      data: json['data'] as Map<String, dynamic>?,
      published: json['published'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  String get displayName => name.isEmpty ? 'Conteúdo $id' : name;
  
  String? get previewImage {
    if (meta != null && meta!['previewImage'] != null) {
      return meta!['previewImage'] as String?;
    }
    return null;
  }
}

