import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inspect_flow/services/api_service.dart';

class InspectionService {
  Future<List<dynamic>> getInspections() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/inspections'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível carregar as inspeções. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! List) {
      throw Exception(
        'A resposta da API para inspeções não é uma lista.',
      );
    }

    return decodedBody;
  }

  Future<Map<String, dynamic>> createInspection({
    required String area,
    required String responsavel,
    required double pontuacao,
    required String classificacao,
    required DateTime dataInspecao,
    required double pontosObtidos,
    required double pontosPossiveis,
    required String planoAcao,
    required Map<String, dynamic> respostas,
    required Map<String, dynamic> comentariosPorBloco,
    required Map<String, dynamic> observacoesPorPergunta,
    required Map<String, dynamic> pontuacoesPorPergunta,
    required Map<String, dynamic> osAbertaPorPergunta,
    required Map<String, dynamic> numerosOsPorPergunta,
    List<Map<String, dynamic>> itensAdicionais = const [],
    List<Map<String, dynamic>> evidencias = const [],
  }) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/inspections'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'area': area,
        'responsavel': responsavel,
        'pontuacao': pontuacao,
        'classificacao': classificacao,
        'dataInspecao': dataInspecao.toIso8601String(),
        'pontosObtidos': pontosObtidos,
        'pontosPossiveis': pontosPossiveis,
        'planoAcao': planoAcao,
        'respostas': respostas,
        'comentariosPorBloco': comentariosPorBloco,
        'observacoesPorPergunta': observacoesPorPergunta,
        'pontuacoesPorPergunta': pontuacoesPorPergunta,
        'osAbertaPorPergunta': osAbertaPorPergunta,
        'numerosOsPorPergunta': numerosOsPorPergunta,
        'itensAdicionais': itensAdicionais,
        'evidencias': evidencias,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(
        'Não foi possível salvar a inspeção. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw Exception(
        'A API retornou uma resposta inválida ao criar a inspeção.',
      );
    }

    return decodedBody;
  }

  Future<Map<String, dynamic>> approveInspection({
    required String id,
    required String nomeAprovador,
    required String comentario,
  }) async {
    final response = await http.patch(
      Uri.parse(
        '${ApiService.baseUrl}/inspections/$id/approve',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nomeAprovador': nomeAprovador,
        'comentario': comentario,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível aprovar a inspeção. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw Exception(
        'A API retornou uma resposta inválida ao aprovar a inspeção.',
      );
    }

    return decodedBody;
  }

  Future<Map<String, dynamic>> rejectInspection({
    required String id,
    required String nomeAprovador,
    required String comentario,
  }) async {
    final response = await http.patch(
      Uri.parse(
        '${ApiService.baseUrl}/inspections/$id/reject',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nomeAprovador': nomeAprovador,
        'comentario': comentario,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível recusar a inspeção. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw Exception(
        'A API retornou uma resposta inválida ao recusar a inspeção.',
      );
    }

    return decodedBody;
  }
}