import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:inspect_flow/services/api_service.dart';
import 'package:http_parser/http_parser.dart';

class EvidenceService {
  Future<Map<String, dynamic>> uploadEvidence({
    required Uint8List bytes,
    required String inspectionId,
    required String referenceId,
    String category = 'pergunta',
  }) async {
    if (bytes.lengthInBytes > 1024 * 1024) {
      throw Exception(
        'A evidência deve ter no máximo 1 MB.',
      );
    }

    final uri = Uri.parse(
      '${ApiService.baseUrl}/evidences/upload',
    );

    final request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.fields['inspectionId'] =
        inspectionId;

    request.fields['referenceId'] =
        referenceId;

    request.fields['category'] =
        category;

    request.files.add(
  http.MultipartFile.fromBytes(
    'file',
    bytes,
    filename:
        '${referenceId}_${DateTime.now().millisecondsSinceEpoch}.jpg',
    contentType: MediaType(
      'image',
      'jpeg',
    ),
  ),
);

    final streamedResponse =
        await request.send();

    final response =
        await http.Response.fromStream(
      streamedResponse,
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(
        'Não foi possível enviar a evidência. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }

    final decodedBody =
        jsonDecode(response.body);

    if (decodedBody is! Map) {
      throw Exception(
        'A API retornou uma resposta inválida '
        'para a evidência.',
      );
    }

    return Map<String, dynamic>.from(
      decodedBody,
    );
  }

  Future<void> saveEvidenceMetadata({
    required String inspectionId,
    required List<Map<String, dynamic>>
        evidencias,
  }) async {
    final response = await http.patch(
      Uri.parse(
        '${ApiService.baseUrl}/inspections/'
        '$inspectionId/evidences',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'evidencias': evidencias,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível vincular as evidências '
        'à inspeção. '
        'Status: ${response.statusCode}. '
        'Resposta: ${response.body}',
      );
    }
  }

  Future<String> getSignedUrl({
    required String path,
  }) async {
    final uri = Uri.parse(
      '${ApiService.baseUrl}/evidences/signed-url',
    ).replace(
      queryParameters: {
        'path': path,
      },
    );

    final response =
        await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível abrir a evidência. '
        'Status: ${response.statusCode}.',
      );
    }

    final decodedBody =
        jsonDecode(response.body);

    if (decodedBody is! Map ||
        decodedBody['signedUrl'] == null) {
      throw Exception(
        'A API não retornou uma URL válida.',
      );
    }

    return decodedBody['signedUrl'].toString();
  }

  Future<Uint8List> downloadEvidence({
    required String path,
  }) async {
    final signedUrl =
        await getSignedUrl(path: path);

    final response = await http.get(
      Uri.parse(signedUrl),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível baixar a evidência.',
      );
    }

    return response.bodyBytes;
  }
}