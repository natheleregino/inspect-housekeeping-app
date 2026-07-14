import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inspect_flow/services/api_service.dart';

class ScheduleService {
  Future<List<Map<String, dynamic>>> getSchedules() async {
    final response = await http.get(
      Uri.parse(
        '${ApiService.baseUrl}/schedules',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível carregar as programações. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! List) {
      throw Exception(
        'A API retornou um formato inválido para programações.',
      );
    }

    return decodedBody
        .whereType<Map>()
        .map(
          (item) => Map<String, dynamic>.from(item),
        )
        .toList();
  }

  Future<Map<String, dynamic>> createSchedule({
    required String area,
    required String responsavel,
    required String supervisor,
    required DateTime dataProgramada,
  }) async {
    final response = await http.post(
      Uri.parse(
        '${ApiService.baseUrl}/schedules',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'area': area,
        'responsavel': responsavel,
        'supervisor': supervisor,
        'dataProgramada': dataProgramada.toIso8601String(),
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(
        'Não foi possível criar a programação. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map) {
      throw Exception(
        'A API retornou um formato inválido '
        'ao criar a programação.',
      );
    }

    return Map<String, dynamic>.from(
      decodedBody,
    );
  }

  Future<Map<String, dynamic>> concludeSchedule({
    required String id,
  }) async {
    debugPrint(
      'CONCLUINDO PROGRAMACAO COM ID: $id',
    );

    final response = await http.patch(
      Uri.parse(
        '${ApiService.baseUrl}/schedules/$id/concluir',
      ),
    );

    debugPrint(
      'STATUS CONCLUSAO: ${response.statusCode}',
    );

    debugPrint(
      'RESPOSTA CONCLUSAO: ${response.body}',
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível concluir a programação. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map) {
      throw Exception(
        'A API retornou um formato inválido '
        'ao concluir a programação.',
      );
    }

    final resultado = Map<String, dynamic>.from(
      decodedBody,
    );

    if (resultado.isEmpty) {
      throw Exception(
        'A programação não foi encontrada no banco.',
      );
    }

    return resultado;
  }

  Future<Map<String, dynamic>> cancelSchedule({
    required String id,
  }) async {
    final response = await http.patch(
      Uri.parse(
        '${ApiService.baseUrl}/schedules/$id/cancelar',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível cancelar a programação. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map) {
      throw Exception(
        'A API retornou um formato inválido '
        'ao cancelar a programação.',
      );
    }

    final resultado = Map<String, dynamic>.from(
      decodedBody,
    );

    if (resultado.isEmpty) {
      throw Exception(
        'A programação não foi encontrada no banco.',
      );
    }

    return resultado;
  }
}