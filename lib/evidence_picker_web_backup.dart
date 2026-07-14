import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

Future<Uint8List?> capturarImagemWeb() async {
  final completer = Completer<Uint8List?>();

  final input = html.FileUploadInputElement()
    ..accept = 'image/*';

  input.setAttribute('capture', 'environment');
  input.click();

  input.onChange.first.then((event) {
    final arquivos = input.files;

    if (arquivos == null || arquivos.isEmpty) {
      completer.complete(null);
      return;
    }

    final arquivo = arquivos.first;
    final leitor = html.FileReader();

    leitor.onLoadEnd.first.then((event) {
      final resultado = leitor.result;

      if (resultado is ByteBuffer) {
        completer.complete(resultado.asUint8List());
      } else if (resultado is Uint8List) {
        completer.complete(resultado);
      } else {
        completer.complete(null);
      }
    });

    leitor.onError.first.then((event) {
      completer.completeError('Erro ao ler a imagem selecionada.');
    });

    leitor.readAsArrayBuffer(arquivo);
  });

  return completer.future;
}
