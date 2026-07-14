import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'evidence_picker.dart';

void abrirImagemGrande(BuildContext context, Uint8List imagemBytes) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Center(
                child: Image.memory(
                  imagemBytes,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void main() {
  runApp(const InspectFsqrCnhApp());
}

class InspectFsqrCnhApp extends StatelessWidget {
  const InspectFsqrCnhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspect FSQR CNH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00843D),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class ItemAdicional {
  final String descricao;
  final String local;
  final String classificacao;
  final String criticidade;
  final String observacao;
  final String acaoRecomendada;
  final bool evidenciaAdicionada;
  final Uint8List? evidenciaBytes;

  const ItemAdicional({
    required this.descricao,
    required this.local,
    required this.classificacao,
    required this.criticidade,
    required this.observacao,
    required this.acaoRecomendada,
    required this.evidenciaAdicionada,
    this.evidenciaBytes,
  });
}

class RelatorioPendente {
  final String titulo;
  final String setor;
  final double percentualConformidade;
  final double percentualNC;
  final int totalItensAdicionais;
  final DateTime dataEnvio;

  final List<String> perguntas;
  final List<String?> respostas;
  final List<String> observacoes;
  final List<bool> evidenciasAdicionadas;
  final List<Uint8List?> evidenciasBytes;
  final List<ItemAdicional> itensAdicionais;

  const RelatorioPendente({
    required this.titulo,
    required this.setor,
    required this.percentualConformidade,
    required this.percentualNC,
    required this.totalItensAdicionais,
    required this.dataEnvio,
    required this.perguntas,
    required this.respostas,
    required this.observacoes,
    required this.evidenciasAdicionadas,
    required this.evidenciasBytes,
    required this.itensAdicionais,
  });
}

final List<RelatorioPendente> relatoriosPendentesAprovacao = [];

int relatoriosAprovadosHoje = 0;
int relatoriosRecusadosHoje = 0;

class RelatorioHistorico {
  final String titulo;
  final String setor;
  final double percentualConformidade;
  final double percentualNC;
  final int totalItensAdicionais;
  final DateTime dataEnvio;
  final DateTime dataDecisao;
  final String status;
  final String? motivoRecusa;

  final List<String> perguntas;
  final List<String?> respostas;
  final List<String> observacoes;
  final List<bool> evidenciasAdicionadas;
  final List<Uint8List?> evidenciasBytes;
  final List<ItemAdicional> itensAdicionais;

  const RelatorioHistorico({
    required this.titulo,
    required this.setor,
    required this.percentualConformidade,
    required this.percentualNC,
    required this.totalItensAdicionais,
    required this.dataEnvio,
    required this.dataDecisao,
    required this.status,
    this.motivoRecusa,
    required this.perguntas,
    required this.respostas,
    required this.observacoes,
    required this.evidenciasAdicionadas,
    required this.evidenciasBytes,
    required this.itensAdicionais,
  });
}

final List<RelatorioHistorico> relatoriosAprovados = [];
final List<RelatorioHistorico> relatoriosRecusados = [];

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void entrarComoInspetor(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(
          perfil: 'Inspetor',
        ),
      ),
    );
  }

  void abrirInspecoesRealizadas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoricoHousekeepingEhsScreen(),
      ),
    );
  }

  void abrirInspecoesProgramadas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InspecoesProgramadasScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              Image.asset(
                'assets/images/FSQR_cargill.png',
                height: 90,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Inspect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00843D),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'Inspect Housekeeping e EHS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Sistema para programação, execução, histórico e acompanhamento das inspeções Housekeeping e EHS.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 36),

              ElevatedButton.icon(
                onPressed: () => entrarComoInspetor(context),
                icon: const Icon(Icons.person_search_outlined),
                label: const Text('Entrar como Inspetor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00843D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              OutlinedButton.icon(
                onPressed: () => abrirInspecoesRealizadas(context),
                icon: const Icon(Icons.assignment_turned_in_outlined),
                label: const Text('Visualizar inspeções realizadas'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00843D),
                  side: const BorderSide(
                    color: Color(0xFF00843D),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              OutlinedButton.icon(
                onPressed: () => abrirInspecoesProgramadas(context),
                icon: const Icon(Icons.event_available_outlined),
                label: const Text('Inspeções programadas'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00843D),
                  side: const BorderSide(
                    color: Color(0xFF00843D),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Nath V.1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HousekeepingEhsChecklistScreen extends StatefulWidget {
  const HousekeepingEhsChecklistScreen({super.key});

  @override
  State<HousekeepingEhsChecklistScreen> createState() =>
      _HousekeepingEhsChecklistScreenState();
}

class _HousekeepingEhsChecklistScreenState
    extends State<HousekeepingEhsChecklistScreen> {
  String? responsavelSelecionado;
  String? areaSelecionada;

final Map<String, String?> respostas = {};
final Map<String, Uint8List?> evidencias = {};
final Map<String, TextEditingController> comentariosPorBloco = {};
final Map<String, TextEditingController> observacoesPorPergunta = {};
final Map<String, bool?> osAbertaPorPergunta = {};
final Map<String, TextEditingController> numeroOsPorPergunta = {};
final TextEditingController planoAcaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    for (final bloco in blocosChecklistHousekeepingEhs) {
      comentariosPorBloco[bloco.id] = TextEditingController();

     for (final pergunta in bloco.perguntas) {
  respostas[pergunta.id] = null;
  evidencias[pergunta.id] = null;
  observacoesPorPergunta[pergunta.id] = TextEditingController();
  osAbertaPorPergunta[pergunta.id] = null;
  numeroOsPorPergunta[pergunta.id] = TextEditingController();
}
    }
  }

@override
void dispose() {
  for (final controller in comentariosPorBloco.values) {
    controller.dispose();
  }

  for (final controller in observacoesPorPergunta.values) {
    controller.dispose();
  }

  for (final controller in numeroOsPorPergunta.values) {
    controller.dispose();
  }

  planoAcaoController.dispose();

  super.dispose();
}

  Future<void> capturarEvidenciaPergunta(String perguntaId) async {
    final bytes = await capturarImagemWeb();

    if (bytes == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma imagem foi selecionada.'),
        ),
      );
      return;
    }

    setState(() {
      evidencias[perguntaId] = bytes;
    });
  }

  void removerEvidenciaPergunta(String perguntaId) {
    setState(() {
      evidencias[perguntaId] = null;
    });
  }

 void mostrarHistoricoItem({
  required String area,
  required String perguntaId,
}) {
  final chave = gerarChaveHistoricoPergunta(
    area: area,
    perguntaId: perguntaId,
  );

  final total = totalInspecoesPorItem[chave] ?? 0;
  final nc = totalNaoAtendePorItem[chave] ?? 0;
  final percentual = total == 0 ? 0 : (nc / total) * 100;
  final observacoesHistoricas =
    historicoObservacoesNaoAtendePorItem[chave] ?? [];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFF59E0B),
            ),
            SizedBox(width: 8),
            Text('Histórico do item'),
          ],
        ),
        
        content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    const SizedBox(height: 6),

    Text(
      '$nc / $total Não conformes',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
    ),

    const SizedBox(height: 8),

    Text(
      '${percentual.toStringAsFixed(1)}% de reincidência',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
      ),
    ),

    if (observacoesHistoricas.isNotEmpty) ...[
      const SizedBox(height: 16),

      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Observações anteriores:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
      ),

      const SizedBox(height: 8),

      SizedBox(
        height: 160,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: observacoesHistoricas.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Text(
                observacoesHistoricas[index],
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4B5563),
                  height: 1.3,
                ),
              ),
            );
          },
        ),
      ),
    ],
  ],
),


        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

 void responderPergunta({
  required PerguntaChecklistPadrao pergunta,
  required String resposta,
}) {
  if (areaSelecionada == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Selecione a área de inspeção antes de responder.'),
      ),
    );
    return;
  }

  setState(() {
    respostas[pergunta.id] = resposta;

    if (resposta != 'Não Atende') {
      osAbertaPorPergunta[pergunta.id] = null;
      numeroOsPorPergunta[pergunta.id]?.clear();
    }
  });

  if (resposta == 'Não Atende') {
    mostrarHistoricoItem(
      area: areaSelecionada!,
      perguntaId: pergunta.id,
    );
  }
}

  Widget construirCabecalhoFormulario() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Dados da inspeção',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: responsavelSelecionado,
              decoration: const InputDecoration(
                labelText: 'Responsável pela inspeção',
                border: OutlineInputBorder(),
              ),
              items: responsaveisInspecaoHousekeepingEhs.map((nome) {
                return DropdownMenuItem(
                  value: nome,
                  child: Text(nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  responsavelSelecionado = value;
                });
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: areaSelecionada,
              decoration: const InputDecoration(
                labelText: 'Área de inspeção',
                border: OutlineInputBorder(),
              ),
              items: areasInspecaoHousekeepingEhs.map((area) {
                return DropdownMenuItem(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  areaSelecionada = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

bool itemTemReincidencia(String perguntaId) {
  if (areaSelecionada == null) {
    return false;
  }

  final chave = gerarChaveHistoricoPergunta(
    area: areaSelecionada!,
    perguntaId: perguntaId,
  );

  final totalNaoAtendeAnterior = totalNaoAtendePorItem[chave] ?? 0;

  return totalNaoAtendeAnterior > 0;
}

  Widget construirPergunta({
    required PerguntaChecklistPadrao pergunta,
    required int numeroVisual,
  }) {
    final respostaSelecionada = respostas[pergunta.id];
final evidencia = evidencias[pergunta.id];
final observacaoController = observacoesPorPergunta[pergunta.id]!;
final reincidente = itemTemReincidencia(pergunta.id);
final osAberta = osAbertaPorPergunta[pergunta.id];
final numeroOsController = numeroOsPorPergunta[pergunta.id]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$numeroVisual. ${pergunta.texto}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: opcoesRespostaHousekeepingEhs.map((opcao) {
              final selecionado = respostaSelecionada == opcao;

              Color cor;
              if (opcao == 'Não Atende') {
                cor = const Color(0xFFC62828);
              } else if (opcao == 'Parcial') {
                cor = const Color(0xFFF59E0B);
              } else if (opcao == 'Atende') {
                cor = const Color(0xFF00843D);
              } else {
                cor = const Color(0xFF6B7280);
              }

              return ChoiceChip(
                label: Text(opcao),
                selected: selecionado,
                selectedColor: cor.withAlpha(35),
                labelStyle: TextStyle(
                  color: selecionado ? cor : const Color(0xFF374151),
                  fontWeight:
                      selecionado ? FontWeight.bold : FontWeight.normal,
                ),
                side: BorderSide(
                  color: selecionado ? cor : const Color(0xFFD1D5DB),
                ),
                onSelected: (_) {
                  responderPergunta(
                    pergunta: pergunta,
                    resposta: opcao,
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

TextField(
  controller: observacaoController,
  minLines: 2,
  maxLines: 4,
  decoration: const InputDecoration(
    labelText: 'Observação da pergunta',
    alignLabelWithHint: true,
    border: OutlineInputBorder(),
  ),
),

if (respostaSelecionada == 'Não Atende' && reincidente) ...[
  const SizedBox(height: 12),

  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xFFF59E0B),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Este item possui reincidência.',
          style: TextStyle(
            color: Color(0xFF92400E),
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Tem O.S. aberta?',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(
              label: const Text('Sim'),
              selected: osAberta == true,
              selectedColor: const Color(0xFFE8F5E9),
              onSelected: (_) {
                setState(() {
                  osAbertaPorPergunta[pergunta.id] = true;
                });
              },
            ),
            ChoiceChip(
              label: const Text('Não'),
              selected: osAberta == false,
              selectedColor: const Color(0xFFFFEBEE),
              onSelected: (_) {
                setState(() {
                  osAbertaPorPergunta[pergunta.id] = false;
                  numeroOsPorPergunta[pergunta.id]?.clear();
                });
              },
            ),
          ],
        ),

        if (osAberta == true) ...[
          const SizedBox(height: 12),
          TextField(
            controller: numeroOsController,
            decoration: const InputDecoration(
              labelText: 'Número da O.S.',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ],
    ),
  ),
],

          if (evidencia != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                abrirImagemGrande(context, evidencia);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  evidencia,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              if (evidencia != null) {
                removerEvidenciaPergunta(pergunta.id);
              } else {
                capturarEvidenciaPergunta(pergunta.id);
              }
            },
            icon: Icon(
              evidencia != null
                  ? Icons.delete_outline
                  : Icons.add_a_photo_outlined,
            ),
            label: Text(
              evidencia != null
                  ? 'Remover evidência'
                  : 'Capturar foto/evidência',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: evidencia != null
                  ? const Color(0xFFC62828)
                  : const Color(0xFF00843D),
              side: BorderSide(
                color: evidencia != null
                    ? const Color(0xFFC62828)
                    : const Color(0xFF00843D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget construirBloco(BlocoChecklistPadrao bloco) {
    final comentarioController = comentariosPorBloco[bloco.id]!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              bloco.titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            ...List.generate(bloco.perguntas.length, (index) {
              return construirPergunta(
                pergunta: bloco.perguntas[index],
                numeroVisual: index + 1,
              );
            }),

            const SizedBox(height: 12),

            TextField(
              controller: comentarioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: bloco.tituloComentario,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget construirPlanoAcaoFinal() {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Plano de ação',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sugestão de plano de ação para algum item em não conformidade.',
            style: TextStyle(
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: planoAcaoController,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Descreva a sugestão de plano de ação',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
  );
}

 bool formularioValido() {
  if (responsavelSelecionado == null || areaSelecionada == null) {
    return false;
  }

  for (final bloco in blocosChecklistHousekeepingEhs) {
    for (final pergunta in bloco.perguntas) {
      final resposta = respostas[pergunta.id];

      if (resposta == null) {
        return false;
      }

      if (resposta == 'Não Atende' && itemTemReincidencia(pergunta.id)) {
        final osAberta = osAbertaPorPergunta[pergunta.id];

        if (osAberta == null) {
          return false;
        }

        if (osAberta == true) {
          final numeroOs =
              numeroOsPorPergunta[pergunta.id]?.text.trim() ?? '';

          if (numeroOs.isEmpty) {
            return false;
          }
        }
      }
    }
  }

  return true;
}

double calcularPontosDaResposta({
  required String resposta,
  required String area,
  required String perguntaId,
}) {
  if (resposta == 'Atende') {
    return 10;
  }

  if (resposta == 'Parcial') {
    return 7;
  }

  if (resposta == 'Não Atende') {
    final chave = gerarChaveHistoricoPergunta(
      area: area,
      perguntaId: perguntaId,
    );

    final totalNaoAtendeAnterior = totalNaoAtendePorItem[chave] ?? 0;

    if (totalNaoAtendeAnterior > 0) {
      final temOsAberta = osAbertaPorPergunta[perguntaId] == true;
      final numeroOs = numeroOsPorPergunta[perguntaId]?.text.trim() ?? '';

      if (temOsAberta && numeroOs.isNotEmpty) {
        return 3;
      }

      return 0;
    }

    return 3;
  }

  return 0;
}

Map<String, double?> calcularPontuacoesPorPergunta() {
  final Map<String, double?> pontuacoes = {};

  if (areaSelecionada == null) {
    return pontuacoes;
  }

  for (final bloco in blocosChecklistHousekeepingEhs) {
    for (final pergunta in bloco.perguntas) {
      final resposta = respostas[pergunta.id];

      if (resposta == null || resposta == 'N/A') {
        pontuacoes[pergunta.id] = null;
        continue;
      }

      pontuacoes[pergunta.id] = calcularPontosDaResposta(
        resposta: resposta,
        area: areaSelecionada!,
        perguntaId: pergunta.id,
      );
    }
  }

  return pontuacoes;
}

Map<String, dynamic> calcularPontuacaoChecklistAtual() {
  double pontosObtidos = 0;
  double pontosPossiveis = 0;

  if (areaSelecionada == null) {
    return {
      'pontosObtidos': 0.0,
      'pontosPossiveis': 0.0,
      'percentual': 0.0,
      'classificacao': 'Sem pontuação',
    };
  }

  for (final bloco in blocosChecklistHousekeepingEhs) {
    for (final pergunta in bloco.perguntas) {
      final resposta = respostas[pergunta.id];

      if (resposta == null) {
        continue;
      }

      if (resposta == 'N/A') {
        continue;
      }

      pontosPossiveis += 10;

      pontosObtidos += calcularPontosDaResposta(
        resposta: resposta,
        area: areaSelecionada!,
        perguntaId: pergunta.id,
      );
    }
  }

  final percentual = pontosPossiveis == 0
      ? 0.0
      : (pontosObtidos / pontosPossiveis) * 100;

  String classificacao;

  if (percentual >= 90) {
    classificacao = 'Excelente';
  } else if (percentual >= 75) {
    classificacao = 'Bom';
  } else if (percentual >= 60) {
    classificacao = 'Atenção';
  } else {
    classificacao = 'Crítico';
  }

  return {
    'pontosObtidos': pontosObtidos,
    'pontosPossiveis': pontosPossiveis,
    'percentual': percentual,
    'classificacao': classificacao,
  };
}

  void registrarHistoricoDoChecklistFinalizado() {
  if (areaSelecionada == null) {
    return;
  }

  for (final bloco in blocosChecklistHousekeepingEhs) {
    for (final pergunta in bloco.perguntas) {
      final resposta = respostas[pergunta.id];

      if (resposta == null) {
        continue;
      }

      final chave = gerarChaveHistoricoPergunta(
        area: areaSelecionada!,
        perguntaId: pergunta.id,
      );

      totalInspecoesPorItem[chave] =
          (totalInspecoesPorItem[chave] ?? 0) + 1;

      if (resposta == 'Não Atende') {
  totalNaoAtendePorItem[chave] =
      (totalNaoAtendePorItem[chave] ?? 0) + 1;

  final observacao =
      observacoesPorPergunta[pergunta.id]?.text.trim() ?? '';

  final agora = DateTime.now();

  final dataFormatada =
      '${agora.day.toString().padLeft(2, '0')}/'
      '${agora.month.toString().padLeft(2, '0')}/'
      '${agora.year} '
      '${agora.hour.toString().padLeft(2, '0')}:'
      '${agora.minute.toString().padLeft(2, '0')}';

  final textoObservacao = observacao.isEmpty
      ? 'Sem observação registrada.'
      : observacao;

  historicoObservacoesNaoAtendePorItem.putIfAbsent(chave, () => []);

  historicoObservacoesNaoAtendePorItem[chave]!.add(
    '$dataFormatada - $textoObservacao',
  );
}
    }
  }
}

 void finalizarChecklist() {
 if (!formularioValido()) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Preencha responsável, área, respostas e dados de O.S. quando houver reincidência.',
      ),
    ),
  );
  return;
}

  final pontuacao = calcularPontuacaoChecklistAtual();
  final pontuacoesPorPergunta = calcularPontuacoesPorPergunta();
  final Map<String, String> comentariosFinais = {};

  for (final entry in comentariosPorBloco.entries) {
    comentariosFinais[entry.key] = entry.value.text.trim();
  }

  final Map<String, bool?> osFinais = {};
final Map<String, String> numerosOsFinais = {};

for (final bloco in blocosChecklistHousekeepingEhs) {
  for (final pergunta in bloco.perguntas) {
    osFinais[pergunta.id] = osAbertaPorPergunta[pergunta.id];
    numerosOsFinais[pergunta.id] =
        numeroOsPorPergunta[pergunta.id]?.text.trim() ?? '';
  }
}

  final relatorio = HistoricoHousekeepingEhs(
    responsavel: responsavelSelecionado!,
    area: areaSelecionada!,
    dataHora: DateTime.now(),
    blocos: List<BlocoChecklistPadrao>.from(blocosChecklistHousekeepingEhs),
    respostas: Map<String, String?>.from(respostas),
    evidencias: Map<String, Uint8List?>.from(evidencias),
    comentariosPorBloco: Map<String, String>.from(comentariosFinais),
    planoAcao: planoAcaoController.text.trim(),
    pontosObtidos: pontuacao['pontosObtidos'] as double,
    pontosPossiveis: pontuacao['pontosPossiveis'] as double,
    pontuacaoPercentual: pontuacao['percentual'] as double,
    classificacaoPontuacao: pontuacao['classificacao'] as String,
    pontuacoesPorPergunta: Map<String, double?>.from(pontuacoesPorPergunta),
    osAbertaPorPergunta: Map<String, bool?>.from(osFinais),
    numerosOsPorPergunta: Map<String, String>.from(numerosOsFinais),
  );

  historicoHousekeepingEhs.add(relatorio);

  registrarHistoricoDoChecklistFinalizado();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultadoHousekeepingEhsScreen(
        responsavel: relatorio.responsavel,
        area: relatorio.area,
        blocos: relatorio.blocos,
        respostas: relatorio.respostas,
        evidencias: relatorio.evidencias,
        comentariosPorBloco: relatorio.comentariosPorBloco,
        planoAcao: relatorio.planoAcao,
        pontosObtidos: relatorio.pontosObtidos,
        pontosPossiveis: relatorio.pontosPossiveis,
        pontuacaoPercentual: relatorio.pontuacaoPercentual,
        classificacaoPontuacao: relatorio.classificacaoPontuacao,
        pontuacoesPorPergunta: relatorio.pontuacoesPorPergunta,
        osAbertaPorPergunta: relatorio.osAbertaPorPergunta,
        numerosOsPorPergunta: relatorio.numerosOsPorPergunta,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Inspeção Housekeeping e EHS'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          construirCabecalhoFormulario(),

      
...blocosChecklistHousekeepingEhs.map(construirBloco),

construirPlanoAcaoFinal(),

const SizedBox(height: 8),

ElevatedButton.icon(

            onPressed: finalizarChecklist,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Finalizar checklist'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00843D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultadoHousekeepingEhsScreen extends StatelessWidget {
  final String responsavel;
  final String area;
  final List<BlocoChecklistPadrao> blocos;
  final Map<String, String?> respostas;
  final Map<String, Uint8List?> evidencias;
  final Map<String, String> comentariosPorBloco;
  final String planoAcao;
  final double pontosObtidos;
  final double pontosPossiveis;
  final double pontuacaoPercentual;
  final String classificacaoPontuacao;
  final Map<String, double?> pontuacoesPorPergunta;
  final Map<String, bool?> osAbertaPorPergunta;
  final Map<String, String> numerosOsPorPergunta;

  const ResultadoHousekeepingEhsScreen({
    super.key,
    required this.responsavel,
    required this.area,
    required this.blocos,
    required this.respostas,
    required this.evidencias,
    required this.comentariosPorBloco,
    required this.planoAcao,
    required this.pontosObtidos,
    required this.pontosPossiveis,
    required this.pontuacaoPercentual,
    required this.classificacaoPontuacao,
    required this.pontuacoesPorPergunta,
    required this.osAbertaPorPergunta,
    required this.numerosOsPorPergunta,
  });

  int contarRespostas(String respostaEsperada) {
    int total = 0;

    for (final resposta in respostas.values) {
      if (resposta == respostaEsperada) {
        total++;
      }
    }

    return total;
  }

  int totalPerguntas() {
    int total = 0;

    for (final bloco in blocos) {
      total += bloco.perguntas.length;
    }

    return total;
  }

  int totalEvidencias() {
    int total = 0;

    for (final evidencia in evidencias.values) {
      if (evidencia != null) {
        total++;
      }
    }

    return total;
  }

  Widget construirLinhaResumo({
    required String titulo,
    required String valor,
    required IconData icone,
    required Color cor,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: 0,
        vertical: -2,
      ),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: cor.withAlpha(25),
        child: Icon(
          icone,
          color: cor,
          size: 20,
        ),
      ),
      title: Text(
        titulo,
        style: const TextStyle(
          color: Color(0xFF4B5563),
          fontSize: 13,
        ),
      ),
      trailing: Text(
        valor,
        style: TextStyle(
          color: cor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget construirBlocoResultado(
    BuildContext context,
    BlocoChecklistPadrao bloco,
  ) {
    final comentario = comentariosPorBloco[bloco.id] ?? '';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              bloco.titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            ...List.generate(bloco.perguntas.length, (index) {
              final pergunta = bloco.perguntas[index];
              final resposta = respostas[pergunta.id] ?? 'Não respondida';
              final evidencia = evidencias[pergunta.id];
              final notaItem = pontuacoesPorPergunta[pergunta.id];
              final osAberta = osAbertaPorPergunta[pergunta.id];
              final numeroOs = numerosOsPorPergunta[pergunta.id] ?? '';

              Color corResposta;

              if (resposta == 'Não Atende') {
                corResposta = const Color(0xFFC62828);
              } else if (resposta == 'Parcial') {
                corResposta = const Color(0xFFF59E0B);
              } else if (resposta == 'Atende') {
                corResposta = const Color(0xFF00843D);
              } else {
                corResposta = const Color(0xFF6B7280);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${index + 1}. ${pergunta.texto}',
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Resposta: ',
                          style: TextStyle(
                            color: Color(0xFF4B5563),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            resposta,
                            style: TextStyle(
                              color: corResposta,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

Align(
  alignment: Alignment.centerLeft,
  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF6FF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: const Color(0xFFBFDBFE),
      ),
    ),
    child: Text(
      notaItem == null
          ? 'Nota do item: N/A'
          : 'Nota do item: ${notaItem.toStringAsFixed(1)} / 10',
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF2563EB),
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

if (resposta == 'Não Atende' && osAberta != null) ...[
  const SizedBox(height: 6),

  Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: osAberta
          ? const Color(0xFFE8F5E9)
          : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: osAberta
            ? const Color(0xFF00843D)
            : const Color(0xFFC62828),
      ),
    ),
    child: Text(
      osAberta
          ? 'O.S. aberta: Sim | Nº: ${numeroOs.isEmpty ? 'Não informado' : numeroOs}'
          : 'O.S. aberta: Não',
      style: TextStyle(
        fontSize: 11,
        color: osAberta
            ? const Color(0xFF00843D)
            : const Color(0xFFC62828),
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
],

                    const SizedBox(height: 6),

                    Text(
                      evidencia != null
                          ? 'Evidência: adicionada ✅'
                          : 'Evidência: não adicionada',
                      style: TextStyle(
                        color: evidencia != null
                            ? const Color(0xFF00843D)
                            : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (evidencia != null) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          abrirImagemGrande(context, evidencia);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            evidencia,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),

            const SizedBox(height: 8),

            const Text(
              'Comentário do critério',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Text(
                comentario.trim().isEmpty
                    ? 'Nenhum comentário informado.'
                    : comentario,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget construirCardPlanoAcao() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Plano de ação',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Text(
                planoAcao.trim().isEmpty
                    ? 'Nenhuma sugestão de plano de ação informada.'
                    : planoAcao,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color corDaPontuacao() {
    if (pontuacaoPercentual >= 90) {
      return const Color(0xFF00843D);
    }

    if (pontuacaoPercentual >= 75) {
      return const Color(0xFF2E7D32);
    }

    if (pontuacaoPercentual >= 60) {
      return const Color(0xFFF59E0B);
    }

    return const Color(0xFFC62828);
  }

  Widget construirCardPontuacao() {
    final cor = corDaPontuacao();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pontuação do checklist',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              '${pontuacaoPercentual.toStringAsFixed(1)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              classificacaoPontuacao,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cor,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              '${pontosObtidos.toStringAsFixed(1)} de ${pontosPossiveis.toStringAsFixed(1)} pontos possíveis',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: pontuacaoPercentual / 100,
                minHeight: 10,
                backgroundColor: const Color(0xFFE5E7EB),
                color: cor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = totalPerguntas();
    final totalNaoAtende = contarRespostas('Não Atende');
    final totalParcial = contarRespostas('Parcial');
    final totalAtende = contarRespostas('Atende');
    final totalNa = contarRespostas('N/A');
    final qtdEvidencias = totalEvidencias();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Resultado Housekeeping e EHS'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    size: 44,
                    color: Color(0xFF00843D),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Inspeção finalizada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Responsável: $responsavel',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Área: $area',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),
            ),
          ),

          construirCardPontuacao(),

          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                construirLinhaResumo(
                  titulo: 'Total de perguntas',
                  valor: total.toString(),
                  icone: Icons.list_alt,
                  cor: const Color(0xFF1F2937),
                ),
                const Divider(height: 1),
                construirLinhaResumo(
                  titulo: 'Não Atende',
                  valor: totalNaoAtende.toString(),
                  icone: Icons.cancel_outlined,
                  cor: const Color(0xFFC62828),
                ),
                const Divider(height: 1),
                construirLinhaResumo(
                  titulo: 'Parcial',
                  valor: totalParcial.toString(),
                  icone: Icons.warning_amber_outlined,
                  cor: const Color(0xFFF59E0B),
                ),
                const Divider(height: 1),
                construirLinhaResumo(
                  titulo: 'Atende',
                  valor: totalAtende.toString(),
                  icone: Icons.check_circle_outline,
                  cor: const Color(0xFF00843D),
                ),
                const Divider(height: 1),
                construirLinhaResumo(
                  titulo: 'N/A',
                  valor: totalNa.toString(),
                  icone: Icons.remove_circle_outline,
                  cor: const Color(0xFF6B7280),
                ),
                const Divider(height: 1),
                construirLinhaResumo(
                  titulo: 'Evidências adicionadas',
                  valor: qtdEvidencias.toString(),
                  icone: Icons.photo_camera_outlined,
                  cor: const Color(0xFF2563EB),
                ),
              ],
            ),
          ),

          ...blocos.map(
            (bloco) => construirBlocoResultado(context, bloco),
          ),

          construirCardPlanoAcao(),

          const SizedBox(height: 8),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Concluir e voltar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00843D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String perfil;

  const HomeScreen({
    super.key,
    required this.perfil,
  });

  void abrirHousekeepingEhs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HousekeepingEhsChecklistScreen(),
      ),
    );
  }

  void abrirHistoricoHousekeepingEhs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoricoHousekeepingEhsScreen(),
      ),
    );
  }

  void trocarPerfil(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Área do Inspetor'),
        centerTitle: true,
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => trocarPerfil(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Voltar',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              Image.asset(
                'assets/images/FSQR_cargill.png',
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Inspect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00843D),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Inspeção Housekeeping e EHS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Execute inspeções, registre evidências, acompanhe pontuação e consulte o histórico.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B5563),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 36),

              ElevatedButton.icon(
                onPressed: () => abrirHousekeepingEhs(context),
                icon: const Icon(Icons.cleaning_services_outlined),
                label: const Text('Inspeção Housekeeping e EHS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00843D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              OutlinedButton.icon(
                onPressed: () => abrirHistoricoHousekeepingEhs(context),
                icon: const Icon(Icons.history_outlined),
                label: const Text('Histórico Housekeeping e EHS'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00843D),
                  side: const BorderSide(
                    color: Color(0xFF00843D),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Nath • Housekeeping e EHS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InspecoesProgramadasScreen extends StatelessWidget {
  const InspecoesProgramadasScreen({super.key});

  void abrirVisualizarProgramadas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisualizarInspecoesProgramadasScreen(),
      ),
    );
  }

  void abrirNovaProgramacao(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProgramarInspecaoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Inspeções programadas'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              const Icon(
                Icons.event_available_outlined,
                size: 64,
                color: Color(0xFF00843D),
              ),

              const SizedBox(height: 20),

              const Text(
                'Inspeções programadas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Visualize inspeções já programadas ou realize uma nova programação.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 36),

              ElevatedButton.icon(
                onPressed: () => abrirVisualizarProgramadas(context),
                icon: const Icon(Icons.list_alt_outlined),
                label: const Text('Visualizar inspeções programadas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00843D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              OutlinedButton.icon(
                onPressed: () => abrirNovaProgramacao(context),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Realizar nova programação'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00843D),
                  side: const BorderSide(
                    color: Color(0xFF00843D),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisualizarInspecoesProgramadasScreen extends StatelessWidget {
  const VisualizarInspecoesProgramadasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Inspeções programadas'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Nenhuma inspeção programada ainda.',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ProgramarInspecaoScreen extends StatelessWidget {
  const ProgramarInspecaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Realizar nova programação'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Tela de programação em desenvolvimento.',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ChecklistListScreen extends StatelessWidget {
  const ChecklistListScreen({super.key});

  List<Map<String, dynamic>> get checklists {
    return [
      {
        'titulo': 'Checklist de Laboratório',
        'descricao':
            'Verificação de equipamentos, reagentes, registros e organização.',
        'setor': 'Laboratório',
        'supervisor': 'Supervisor Laboratório',
        'perguntas': [
          'Os equipamentos estão limpos?',
          'Os reagentes estão identificados?',
          'As bancadas estão organizadas?',
          'Os registros estão atualizados?',
          'Há presença de materiais vencidos?',
        ],
      },
      {
        'titulo': 'Checklist de Segurança Operacional',
        'descricao':
            'Inspeção de condições seguras, EPIs e riscos operacionais.',
        'setor': 'Segurança',
        'supervisor': 'Supervisor de Segurança',
        'perguntas': [
          'Os colaboradores estão utilizando EPIs corretamente?',
          'As rotas de fuga estão desobstruídas?',
          'Os extintores estão acessíveis e identificados?',
          'Há sinalização de segurança adequada?',
          'Existem condições inseguras na área?',
        ],
      },
      {
        'titulo': 'Checklist de Limpeza e Organização',
        'descricao':
            'Avaliação de limpeza, identificação e organização da área.',
        'setor': 'Operações',
        'supervisor': 'Supervisor Operações',
        'perguntas': [
          'A área está limpa?',
          'Os materiais estão organizados?',
          'Os itens estão corretamente identificados?',
          'Não há acúmulo de resíduos?',
          'Os corredores estão livres para circulação?',
        ],
      },
    ];
  }

  void abrirPerguntas(BuildContext context, Map<String, dynamic> checklist) {
    Navigator.push(
      context,
      MaterialPageRoute(
      
builder: (context) => ChecklistQuestionsScreen(
  titulo: checklist['titulo'] as String,
  setor: checklist['setor'] as String,
  supervisor: checklist['supervisor'] as String,
  perguntas: List<String>.from(checklist['perguntas'] as List),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Checklists Disponíveis'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          final checklist = checklists[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(
                  Icons.assignment_outlined,
                  color: Color(0xFF00843D),
                ),
              ),
              title: Text(
                checklist['titulo'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF1F2937),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${checklist['descricao']}\n'
                  'Setor: ${checklist['setor']}\n'
                  'Supervisor: ${checklist['supervisor']}',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    height: 1.4,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xFF00843D),
              ),
              onTap: () => abrirPerguntas(context, checklist),
            ),
          );
        },
      ),
    );
  }
}

class ChecklistQuestionsScreen extends StatefulWidget {
  final String titulo;
  final String setor;
  final String supervisor;
  final List<String> perguntas;

  const ChecklistQuestionsScreen({
    super.key,
    required this.titulo,
    required this.setor,
    required this.supervisor,
    required this.perguntas,
  });

  @override
  State<ChecklistQuestionsScreen> createState() {
    return _ChecklistQuestionsScreenState();
  }
}

class _ChecklistQuestionsScreenState extends State<ChecklistQuestionsScreen> {
  late List<String?> respostas;
  late List<TextEditingController> observacaoControllers;
  late List<bool> evidenciasAdicionadas;
  late List<Uint8List?> evidenciasBytes;

  final List<ItemAdicional> itensAdicionais = [];

  @override
  void initState() {
    super.initState();

    respostas = List<String?>.filled(widget.perguntas.length, null);
    evidenciasBytes = List<Uint8List?>.filled(widget.perguntas.length, null);

    observacaoControllers = List.generate(
      widget.perguntas.length,
      (index) => TextEditingController(),
    );

    evidenciasAdicionadas = List<bool>.filled(widget.perguntas.length, false);
  }

  @override
  void dispose() {
    for (final controller in observacaoControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  int get perguntasRespondidas {
    return respostas.where((resposta) => resposta != null).length;
  }

  void selecionarResposta(int index, String resposta) {
    setState(() {
      respostas[index] = resposta;
    });
  }

  Future<void> capturarEvidencia(int index) async {
  try {
    final bytes = await capturarImagemWeb();

    if (bytes == null) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma imagem foi selecionada.'),
        ),
      );
      return;
    }

    setState(() {
      evidenciasBytes[index] = bytes;
      evidenciasAdicionadas[index] = true;
    });
  } catch (erro) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Não foi possível capturar a evidência: $erro',
        ),
      ),
    );
  }
}

void removerEvidencia(int index) {
  setState(() {
    evidenciasBytes[index] = null;
    evidenciasAdicionadas[index] = false;
  });
}

  void removerItemAdicional(int index) {
    setState(() {
      itensAdicionais.removeAt(index);
    });
  }

  Future<void> abrirFormularioItemAdicional() async {
    final ItemAdicional? novoItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ItemAdicionalFormScreen(),
      ),
    );

    if (novoItem != null) {
      setState(() {
        itensAdicionais.add(novoItem);
      });
    }
  }

  Color corResposta(String resposta) {
    if (resposta == 'Conforme') {
      return const Color(0xFF2E7D32);
    }

    if (resposta == 'Não Conforme') {
      return const Color(0xFFC62828);
    }

    if (resposta == 'Não Aplicável') {
      return const Color(0xFF6B7280);
    }

    return const Color(0xFF00843D);
  }

  Color corCriticidade(String criticidade) {
    if (criticidade == 'Crítica') {
      return const Color(0xFFC62828);
    }

    if (criticidade == 'Alta') {
      return const Color(0xFFEF6C00);
    }

    if (criticidade == 'Média') {
      return const Color(0xFFF9A825);
    }

    return const Color(0xFF6B7280);
  }

  void finalizarChecklist() {
    final int conformes =
        respostas.where((resposta) => resposta == 'Conforme').length;

    final int naoConformes =
        respostas.where((resposta) => resposta == 'Não Conforme').length;

    final int naoAplicaveis =
        respostas.where((resposta) => resposta == 'Não Aplicável').length;

    final int totalAplicavel = conformes + naoConformes;

    final double percentualConformidade =
        totalAplicavel == 0 ? 0 : (conformes / totalAplicavel) * 100;

    final double percentualNC =
        totalAplicavel == 0 ? 0 : (naoConformes / totalAplicavel) * 100;

    final List<String> observacoes = observacaoControllers
        .map((controller) => controller.text.trim())
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoChecklistScreen(
          titulo: widget.titulo,
          setor: widget.setor,
          supervisor: widget.supervisor,
          totalPerguntas: widget.perguntas.length,
          conformes: conformes,
          naoConformes: naoConformes,
          naoAplicaveis: naoAplicaveis,
          percentualConformidade: percentualConformidade,
          percentualNC: percentualNC,
          perguntas: widget.perguntas,
          respostas: respostas,
          observacoes: observacoes,
          evidenciasAdicionadas: evidenciasAdicionadas,
          evidenciasBytes: List<Uint8List?>.from(evidenciasBytes),
          itensAdicionais: List<ItemAdicional>.from(itensAdicionais),
        ),
      ),
    );
  }

  Widget construirCardPergunta(int index) {
    final pergunta = widget.perguntas[index];
    final respostaSelecionada = respostas[index];
    final evidenciaAdicionada = evidenciasAdicionadas[index];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pergunta ${index + 1}',
              style: const TextStyle(
                color: Color(0xFF00843D),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pergunta,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                BotaoResposta(
                  texto: 'Conforme',
                  selecionado: respostaSelecionada == 'Conforme',
                  cor: corResposta('Conforme'),
                  onTap: () {
                    selecionarResposta(index, 'Conforme');
                  },
                ),
                BotaoResposta(
                  texto: 'Não Conforme',
                  selecionado: respostaSelecionada == 'Não Conforme',
                  cor: corResposta('Não Conforme'),
                  onTap: () {
                    selecionarResposta(index, 'Não Conforme');
                  },
                ),
                BotaoResposta(
                  texto: 'Não Aplicável',
                  selecionado: respostaSelecionada == 'Não Aplicável',
                  cor: corResposta('Não Aplicável'),
                  onTap: () {
                    selecionarResposta(index, 'Não Aplicável');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: observacaoControllers[index],
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Observação',
                hintText: 'Digite uma observação, se necessário',
                alignLabelWithHint: true,
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF00843D),
                    width: 1.8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: evidenciaAdicionada
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: evidenciaAdicionada
                      ? const Color(0xFF00843D)
                      : const Color(0xFFD1D5DB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Evidência fotográfica',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    evidenciaAdicionada
                        ? 'Evidência adicionada ✅'
                        : 'Nenhuma evidência adicionada',
                    style: TextStyle(
                      color: evidenciaAdicionada
                          ? const Color(0xFF00843D)
                          : const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),

                 if (evidenciasBytes[index] != null) ...[
  const SizedBox(height: 10),
  
  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, evidenciasBytes[index]!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      evidenciasBytes[index]!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
],

  OutlinedButton.icon(
  onPressed: () {
    if (evidenciaAdicionada) {
      removerEvidencia(index);
    } else {
      capturarEvidencia(index);
    }
  },
  icon: Icon(
    evidenciaAdicionada
        ? Icons.delete_outline
        : Icons.add_a_photo_outlined,
  ),
  label: Text(
    evidenciaAdicionada
        ? 'Remover evidência'
        : 'Capturar foto/evidência',
  ),
  style: OutlinedButton.styleFrom(
    foregroundColor: evidenciaAdicionada
        ? const Color(0xFFC62828)
        : const Color(0xFF00843D),
    side: BorderSide(
      color: evidenciaAdicionada
          ? const Color(0xFFC62828)
          : const Color(0xFF00843D),
    ),
  ),
),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget construirSecaoItensAdicionais() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Itens adicionais',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Registre desvios, observações ou itens inspecionados que não fazem parte das perguntas padrão do checklist.',
              style: TextStyle(
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            if (itensAdicionais.isEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: const Text(
                  'Nenhum item adicional registrado.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            if (itensAdicionais.isNotEmpty)
              ...List.generate(itensAdicionais.length, (index) {
                final item = itensAdicionais[index];
                final cor = corCriticidade(item.criticidade);

                return Container(
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFFF9FAFB),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: const Color(0xFFE5E7EB),
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Item adicional ${index + 1}',
        style: const TextStyle(
          color: Color(0xFF00843D),
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 6),

      Text(
        item.descricao,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),

      const SizedBox(height: 6),

      Text(
        'Local: ${item.local}',
        style: const TextStyle(
          color: Color(0xFF4B5563),
        ),
      ),

      const SizedBox(height: 6),

      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Chip(
            label: Text(item.classificacao),
            backgroundColor: const Color(0xFFE8F5E9),
            labelStyle: const TextStyle(
              color: Color(0xFF00843D),
              fontWeight: FontWeight.w600,
            ),
          ),
          Chip(
            label: Text(item.criticidade),
            backgroundColor: cor.withAlpha(35),
            labelStyle: TextStyle(
              color: cor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),

      const SizedBox(height: 6),

      Text(
        item.evidenciaAdicionada
            ? 'Evidência: adicionada ✅'
            : 'Evidência: não adicionada',
        style: TextStyle(
          color: item.evidenciaAdicionada
              ? const Color(0xFF00843D)
              : const Color(0xFF6B7280),
          fontWeight: FontWeight.w500,
        ),
      ),

if (item.evidenciaBytes != null) ...[
  const SizedBox(height: 8),

  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, evidenciasBytes[index]!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      evidenciasBytes[index]!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
],

      Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () => removerItemAdicional(index),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Remover'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFC62828),
          ),
        ),
      ),
    ],
  ),
);
}),
const SizedBox(height: 12),
OutlinedButton.icon(
  onPressed: abrirFormularioItemAdicional,
  icon: const Icon(Icons.add),
  label: const Text('Registrar item adicional'),
  style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF00843D),
    side: const BorderSide(
      color: Color(0xFF00843D),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
    ),
  ),
),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double progresso = perguntasRespondidas / widget.perguntas.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Responder Checklist'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Setor: ${widget.setor}',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supervisor responsável: ${widget.supervisor}',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 15,
                  ),
               ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progresso,
                  backgroundColor: const Color(0xFFE5E7EB),
                  color: const Color(0xFF00843D),
                ),
                const SizedBox(height: 6),
                Text(
                  '$perguntasRespondidas de ${widget.perguntas.length} perguntas respondidas',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...List.generate(
                  widget.perguntas.length,
                  (index) => construirCardPergunta(index),
                ),
                construirSecaoItensAdicionais(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: ElevatedButton.icon(
              onPressed: perguntasRespondidas == widget.perguntas.length
                  ? finalizarChecklist
                  : null,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Finalizar Checklist'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00843D),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFCBD5E1),
                disabledForegroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class PerguntaChecklistPadrao {
  final String id;
  final String texto;

  const PerguntaChecklistPadrao({
    required this.id,
    required this.texto,
  });
}

class BlocoChecklistPadrao {
  final String id;
  final String titulo;
  final String tituloComentario;
  final List<PerguntaChecklistPadrao> perguntas;

  const BlocoChecklistPadrao({
    required this.id,
    required this.titulo,
    required this.tituloComentario,
    required this.perguntas,
  });
}

const List<String> responsaveisInspecaoHousekeepingEhs = [
  'Alessandro Seibert',
  'Alvaro Dpg',
  'Ana Moreira',
  'Artur Batista',
  'Ayla Coqueiro',
  'Caio Ishikura',
  'Camila Souza',
  'Claudia Matos',
  'Eduardo Moura',
  'Gabriela Milhomens',
  'Jose Duarte',
  'Josemar Santana',
  'Josiane Barbosa',
  'Laressa Lima',
  'Leandro Pereira',
  'Leandro Rocha',
  'Leonidas Araujo',
  'Lucas Souza',
  'Luciano Cunha',
  'Luis Pereira',
  'Marcio Roberto',
  'Marcos Teixeira',
  'Rafael Paz',
  'Roberto Andrade',
  'Sergio Silva',
  'Taiane Silva',
  'Vitor Gomes',
  'Walber Divino',
  'Wanderson Nunes',
  'Washington Cirqueira',
];

const List<String> areasInspecaoHousekeepingEhs = [
  'Expedição de Farelo',
  'Manutenção',
  'Preparação',
  'Extração',
  'FSQR',
  'Recebimento',
  'Biodiesel e ETE',
  'Degomagem',
  'Carregamento Biodiesel',
  'Utilidades',
  'ADM',
  'Portaria',
];

const List<String> opcoesRespostaHousekeepingEhs = [
  'Não Atende',
  'Parcial',
  'Atende',
  'N/A',
];

const BlocoChecklistPadrao blocoHousekeepingEhs = BlocoChecklistPadrao(
  id: '3',
  titulo: 'Housekeeping',
  tituloComentario: 'Comentários sobre o critério: Housekeeping',
  perguntas: [
    PerguntaChecklistPadrao(
      id: '3.1',
      texto:
          'Ausência de objetos, equipamentos e/ou materiais em desuso no meio da passagem de pessoas e/ou equipamentos elétricos?',
    ),
    PerguntaChecklistPadrao(
      id: '3.2',
      texto: 'Iluminação adequada?',
    ),
    PerguntaChecklistPadrao(
      id: '3.3',
      texto:
          'A organização da área está adequada, incluindo artigos avulsos e armários?',
    ),
    PerguntaChecklistPadrao(
      id: '3.4',
      texto:
          'Ausência de materiais pontiagudos/cortantes na área, como vidros, objetos ou materiais quebrados, visores de equipamentos, parafusos e madeira?',
    ),
    PerguntaChecklistPadrao(
      id: '3.5',
      texto:
          'Os pisos, superfícies de equipamentos, corrimões, tubulações e estruturas aéreas, paredes, tetos, vigas, prateleiras, telhados, luminárias, lâmpadas, calhas, tubos, bandejas e caixas elétricas se encontram livres do acúmulo de poeiras maior que 3,2mm?',
    ),
    PerguntaChecklistPadrao(
      id: '3.6',
      texto:
          'Túneis e fossos de equipamentos se encontram livres de acúmulo de poeiras combustíveis maior que 3,2mm?',
    ),
    PerguntaChecklistPadrao(
      id: '3.7',
      texto:
          'Motores, mancais e estruturas de proteção de equipamentos encontram-se livres de acúmulo de poeira maior que 3,2mm?',
    ),
    PerguntaChecklistPadrao(
      id: '3.8',
      texto:
          'Equipamentos de processo possuem vazamentos de material sólido ou poeiras combustíveis?',
    ),
    PerguntaChecklistPadrao(
      id: '3.9',
      texto:
          'Verificou-se a presença de poeira combustível em suspensão na área de processo durante a inspeção?',
    ),
    PerguntaChecklistPadrao(
      id: '3.10',
      texto:
          'Local sem sinais de pragas, incluindo teias de aranha e fezes de pássaros, com estruturas para prevenir acessos, como telas, com armadilhas identificadas, limpas e sem obstrução; registro de monitoramento integrado de pragas disponível e preenchido?',
    ),
    PerguntaChecklistPadrao(
      id: '3.11',
      texto:
          'Funcionários sem adornos, com uniformes limpos e em bom estado de conservação. Ausência de evidências de comidas, balas e chicletes na área?',
    ),
    PerguntaChecklistPadrao(
      id: '3.12',
      texto: 'Lixeiras identificadas, com tampa e em locais apropriados?',
    ),
    PerguntaChecklistPadrao(
      id: '3.13',
      texto:
          'A vegetação da área externa está com acero controlado e em condições que evitem o abrigo de pragas?',
    ),
    PerguntaChecklistPadrao(
      id: '3.14',
      texto:
          'Os produtos químicos, como insumos de processo e lubrificantes, encontram-se no local apropriado para tal, sem oferecer risco de contaminação aos produtos e embalagens?',
    ),
  ],
);

const BlocoChecklistPadrao blocoSegurancaEhs = BlocoChecklistPadrao(
  id: '5',
  titulo: 'Segurança',
  tituloComentario: 'Comentários sobre o critério: Segurança',
  perguntas: [
    PerguntaChecklistPadrao(
      id: '5.1',
      texto: 'Riscos de Bloqueio e Etiquetagem',
    ),
    PerguntaChecklistPadrao(
      id: '5.2',
      texto: 'Riscos elétricos',
    ),
    PerguntaChecklistPadrao(
      id: '5.3',
      texto: 'Riscos de trabalho a quente',
    ),
    PerguntaChecklistPadrao(
      id: '5.4',
      texto: 'Riscos de armazenamento de material a granel',
    ),
    PerguntaChecklistPadrao(
      id: '5.5',
      texto: 'Riscos de espaço confinado',
    ),
    PerguntaChecklistPadrao(
      id: '5.6',
      texto: 'Riscos de trabalho em altura',
    ),
    PerguntaChecklistPadrao(
      id: '5.7',
      texto: 'Riscos de falhas em equipamentos',
    ),
    PerguntaChecklistPadrao(
      id: '5.8',
      texto: 'Riscos de proteção de máquinas e equipamentos',
    ),
    PerguntaChecklistPadrao(
      id: '5.9',
      texto: 'Riscos com equipamentos móveis',
    ),
    PerguntaChecklistPadrao(
      id: '5.10',
      texto: 'Riscos de içamento e amarração',
    ),
    PerguntaChecklistPadrao(
      id: '5.11',
      texto: 'Riscos de materiais perigosos',
    ),
    PerguntaChecklistPadrao(
      id: '5.12',
      texto: 'Riscos de segurança no trânsito',
    ),
    PerguntaChecklistPadrao(
      id: '5.13',
      texto: 'Riscos com animais / biológicos',
    ),
    PerguntaChecklistPadrao(
      id: '5.14',
      texto:
          'Os equipamentos de emergência, como chuveiros, extintores, hidrantes, botoeiras e saídas de emergência, estão bem sinalizados e desobstruídos?',
    ),
  ],
);

const BlocoChecklistPadrao blocoSaudeEhs = BlocoChecklistPadrao(
  id: '7',
  titulo: 'Saúde',
  tituloComentario: 'Comentários sobre o critério: Saúde',
  perguntas: [
    PerguntaChecklistPadrao(
      id: '7.1',
      texto: 'Riscos respiratórios',
    ),
    PerguntaChecklistPadrao(
      id: '7.2',
      texto: 'Riscos para a audição',
    ),
    PerguntaChecklistPadrao(
      id: '7.3',
      texto: 'Riscos ergonômicos',
    ),
  ],
);

const BlocoChecklistPadrao blocoMeioAmbienteEhs = BlocoChecklistPadrao(
  id: '9',
  titulo: 'Meio Ambiente',
  tituloComentario: 'Comentários sobre o critério: Meio Ambiente',
  perguntas: [
    PerguntaChecklistPadrao(
      id: '9.1',
      texto: 'Os resíduos estão sendo gerenciados adequadamente?',
    ),
    PerguntaChecklistPadrao(
      id: '9.2',
      texto: 'Equipamentos apresentam vazamento de água e efluente?',
    ),
    PerguntaChecklistPadrao(
      id: '9.3',
      texto:
          'Os equipamentos de emergência ambiental estão sinalizados, desobstruídos e em condições de uso?',
    ),
    PerguntaChecklistPadrao(
      id: '9.4',
      texto: 'Existem emissões atmosféricas fora dos padrões legais?',
    ),
  ],
);

const BlocoChecklistPadrao blocoSegurancaAlimentosEhs = BlocoChecklistPadrao(
  id: '11',
  titulo: 'Segurança dos Alimentos',
  tituloComentario:
      'Comentários sobre o critério: Equipamento e Condições de Processo',
  perguntas: [
    PerguntaChecklistPadrao(
      id: '11.1',
      texto:
          'A Política de Segurança de Alimentos está disponível no setor e é de conhecimento dos colaboradores da área?',
    ),
    PerguntaChecklistPadrao(
      id: '11.2',
      texto:
          'As portas de acessos a áreas críticas de produto acabado encontram-se devidamente fechadas e com controle de acesso?',
    ),
    PerguntaChecklistPadrao(
      id: '11.3',
      texto:
          'A área está livre de materiais utilizados durante reparos, lixo, residual de óleo de lubrificação, cerquite, panos e materiais de limpeza deixados na área?',
    ),
    PerguntaChecklistPadrao(
      id: '11.4',
      texto:
          'Todas as etapas/equipamentos de processo, incluindo máquinas, tubulações e pontos de amostragem, estão fechados e protegidos para prevenir contaminação do produto?',
    ),
  ],
);

class ItemAdicionalFormScreen extends StatefulWidget {
  const ItemAdicionalFormScreen({super.key});

  @override
  State<ItemAdicionalFormScreen> createState() {
    return _ItemAdicionalFormScreenState();
  }
}

const List<BlocoChecklistPadrao> blocosChecklistHousekeepingEhs = [
  blocoHousekeepingEhs,
  blocoSegurancaEhs,
  blocoSaudeEhs,
  blocoMeioAmbienteEhs,
  blocoSegurancaAlimentosEhs,
];

String gerarChaveHistoricoPergunta({
  required String area,
  required String perguntaId,
}) {
  return '${area}_$perguntaId';
}

final Map<String, int> totalInspecoesPorItem = {};
final Map<String, int> totalNaoAtendePorItem = {};
final Map<String, List<String>> historicoObservacoesNaoAtendePorItem = {};

class HistoricoHousekeepingEhs {
  final String responsavel;
  final String area;
  final DateTime dataHora;
  final List<BlocoChecklistPadrao> blocos;
  final Map<String, String?> respostas;
  final Map<String, Uint8List?> evidencias;
  final Map<String, String> comentariosPorBloco;
  final String planoAcao;
  final double pontosObtidos;
  final double pontosPossiveis;
  final double pontuacaoPercentual;
  final String classificacaoPontuacao;
  final Map<String, double?> pontuacoesPorPergunta;
  final Map<String, bool?> osAbertaPorPergunta;
  final Map<String, String> numerosOsPorPergunta;

  const HistoricoHousekeepingEhs({
    required this.responsavel,
    required this.area,
    required this.dataHora,
    required this.blocos,
    required this.respostas,
    required this.evidencias,
    required this.comentariosPorBloco,
    required this.planoAcao,
    required this.pontosObtidos,
    required this.pontosPossiveis,
    required this.pontuacaoPercentual,
    required this.classificacaoPontuacao,
    required this.pontuacoesPorPergunta,
    required this.osAbertaPorPergunta,
    required this.numerosOsPorPergunta,
  });
}

final List<HistoricoHousekeepingEhs> historicoHousekeepingEhs = [];

class HistoricoHousekeepingEhsScreen extends StatelessWidget {
  const HistoricoHousekeepingEhsScreen({super.key});

  String formatarDataHora(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$ano $hora:$minuto';
  }

  int contarNaoAtende(HistoricoHousekeepingEhs relatorio) {
    int total = 0;

    for (final resposta in relatorio.respostas.values) {
      if (resposta == 'Não Atende') {
        total++;
      }
    }

    return total;
  }

  int contarEvidencias(HistoricoHousekeepingEhs relatorio) {
    int total = 0;

    for (final evidencia in relatorio.evidencias.values) {
      if (evidencia != null) {
        total++;
      }
    }

    return total;
  }

  int totalPerguntas(HistoricoHousekeepingEhs relatorio) {
    int total = 0;

    for (final bloco in relatorio.blocos) {
      total += bloco.perguntas.length;
    }

    return total;
  }

  void abrirRelatorio(
    BuildContext context,
    HistoricoHousekeepingEhs relatorio,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoHousekeepingEhsScreen(
          responsavel: relatorio.responsavel,
          area: relatorio.area,
          blocos: relatorio.blocos,
          respostas: relatorio.respostas,
          evidencias: relatorio.evidencias,
          comentariosPorBloco: relatorio.comentariosPorBloco,
          planoAcao: relatorio.planoAcao,
          pontosObtidos: relatorio.pontosObtidos,
          pontosPossiveis: relatorio.pontosPossiveis,
          pontuacaoPercentual: relatorio.pontuacaoPercentual,
          classificacaoPontuacao: relatorio.classificacaoPontuacao,
          pontuacoesPorPergunta: relatorio.pontuacoesPorPergunta,
          osAbertaPorPergunta: relatorio.osAbertaPorPergunta,
          numerosOsPorPergunta: relatorio.numerosOsPorPergunta,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Histórico Housekeeping e EHS'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: historicoHousekeepingEhs.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma inspeção registrada ainda.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...historicoHousekeepingEhs.reversed.map((relatorio) {
                  final total = totalPerguntas(relatorio);
                  final naoAtende = contarNaoAtende(relatorio);
                  final evidencias = contarEvidencias(relatorio);

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            relatorio.area,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Responsável: ${relatorio.responsavel}',
                            style: const TextStyle(
                              color: Color(0xFF4B5563),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Data: ${formatarDataHora(relatorio.dataHora)}',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Wrap(
  spacing: 6,
  runSpacing: 6,
  children: [
    Chip(
      visualDensity: const VisualDensity(
        horizontal: -2,
        vertical: -2,
      ),
      label: Text(
        'Perguntas: $total',
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: const Color(0xFFEFF6FF),
    ),
    Chip(
      visualDensity: const VisualDensity(
        horizontal: -2,
        vertical: -2,
      ),
      label: Text(
        'Não Atende: $naoAtende',
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFFC62828),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFFFFEBEE),
    ),
    Chip(
      visualDensity: const VisualDensity(
        horizontal: -2,
        vertical: -2,
      ),
      label: Text(
        'Evidências: $evidencias',
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF00843D),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFFE8F5E9),
    ),
  ],
),

const SizedBox(height: 10),

Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: const Color(0xFFEFF6FF),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: const Color(0xFFBFDBFE),
    ),
  ),
  child: Text(
    'Pontuação: ${relatorio.pontuacaoPercentual.toStringAsFixed(1)}% - ${relatorio.classificacaoPontuacao}',
    style: const TextStyle(
      color: Color(0xFF2563EB),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  ),
),

                          const SizedBox(height: 12),

                          OutlinedButton.icon(
                            onPressed: () {
                              abrirRelatorio(context, relatorio);
                            },
                            icon: const Icon(
  Icons.visibility_outlined,
  size: 18,
),
                            label: const Text('Abrir relatório completo'),
                            style: OutlinedButton.styleFrom(
  foregroundColor: const Color(0xFF00843D),
  side: const BorderSide(
    color: Color(0xFF00843D),
  ),
  padding: const EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 12,
  ),
  textStyle: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  ),
),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}

class _ItemAdicionalFormScreenState extends State<ItemAdicionalFormScreen> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  final TextEditingController acaoController = TextEditingController();

  String classificacaoSelecionada = 'Desvio';
  String criticidadeSelecionada = 'Baixa';
  bool evidenciaAdicionada = false;
  Uint8List? evidenciaBytes;

  final List<String> classificacoes = const [
    'Desvio',
    'Não conformidade',
    'Oportunidade de melhoria',
    'Condição insegura',
    'Observação geral',
  ];

  final List<String> criticidades = const [
    'Baixa',
    'Média',
    'Alta',
    'Crítica',
  ];

  @override
  void dispose() {
    descricaoController.dispose();
    localController.dispose();
    observacaoController.dispose();
    acaoController.dispose();

    super.dispose();
  }

  void salvarItem() {
    final descricao = descricaoController.text.trim();
    final local = localController.text.trim();
    final observacao = observacaoController.text.trim();
    final acao = acaoController.text.trim();

    if (descricao.isEmpty || local.isEmpty || observacao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha descrição, local e observação para salvar o item adicional.',
          ),
        ),
      );
      return;
    }

    if ((criticidadeSelecionada == 'Alta' ||
            criticidadeSelecionada == 'Crítica') &&
        !evidenciaAdicionada) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Para criticidade Alta ou Crítica, adicione uma evidência simulada.',
          ),
        ),
      );
      return;
    }

    final item = ItemAdicional(
      descricao: descricao,
      local: local,
      classificacao: classificacaoSelecionada,
      criticidade: criticidadeSelecionada,
      observacao: observacao,
      acaoRecomendada: acao,
      evidenciaAdicionada: evidenciaAdicionada,
      evidenciaBytes: evidenciaBytes,
    );

    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Registrar item adicional'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Dados do item adicional',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descricaoController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Descrição',
              hintText: 'Ex.: Material sem identificação na bancada',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF00843D),
                  width: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: localController,
            decoration: InputDecoration(
              labelText: 'Local',
              hintText: 'Ex.: Laboratório - Bancada 2',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF00843D),
                  width: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: classificacaoSelecionada,
            decoration: InputDecoration(
              labelText: 'Classificação',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: classificacoes.map((classificacao) {
              return DropdownMenuItem<String>(
                value: classificacao,
                child: Text(classificacao),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  classificacaoSelecionada = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: criticidadeSelecionada,
            decoration: InputDecoration(
              labelText: 'Criticidade',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: criticidades.map((criticidade) {
              return DropdownMenuItem<String>(
                value: criticidade,
                child: Text(criticidade),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  criticidadeSelecionada = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: observacaoController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Observação',
              hintText: 'Descreva detalhes importantes do item identificado',
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF00843D),
                  width: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: acaoController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Ação recomendada',
              hintText: 'Ex.: Identificar o material e orientar a equipe',
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF00843D),
                  width: 1.8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: evidenciaAdicionada
                  ? const Color(0xFFE8F5E9)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: evidenciaAdicionada
                    ? const Color(0xFF00843D)
                    : const Color(0xFFD1D5DB),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Evidência fotográfica',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  evidenciaAdicionada
                      ? 'Evidência adicionada ✅'
                      : 'Nenhuma evidência adicionada',
                  style: TextStyle(
                    color: evidenciaAdicionada
                        ? const Color(0xFF00843D)
                        : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),

if (evidenciaBytes != null) ...[
  const SizedBox(height: 10),

  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, evidenciaBytes!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      evidenciaBytes!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
  const SizedBox(height: 10),
],

                OutlinedButton.icon(
  onPressed: () async {
    if (evidenciaAdicionada) {
      setState(() {
  evidenciaAdicionada = false;
  evidenciaBytes = null;
});
      return;
    }

    final bytes = await capturarImagemWeb();

    if (bytes == null) {
      return;
    }

    setState(() {
      evidenciaBytes = bytes;
      evidenciaAdicionada = true;
    });
  },
  icon: Icon(
    evidenciaAdicionada
        ? Icons.delete_outline
        : Icons.add_a_photo_outlined,
  ),
  label: Text(
    evidenciaAdicionada
        ? 'Remover evidência'
        : 'Capturar foto/evidência',
  ),
  style: OutlinedButton.styleFrom(
    foregroundColor: evidenciaAdicionada
        ? const Color(0xFFC62828)
        : const Color(0xFF00843D),
    side: BorderSide(
      color: evidenciaAdicionada
          ? const Color(0xFFC62828)
          : const Color(0xFF00843D),
    ),
  ),
),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: salvarItem,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Salvar item adicional'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00843D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultadoChecklistScreen extends StatelessWidget {
  final String titulo;
  final String setor;
  final String supervisor;
  final int totalPerguntas;
  final int conformes;
  final int naoConformes;
  final int naoAplicaveis;
  final double percentualConformidade;
  final double percentualNC;
  final List<String> perguntas;
  final List<String?> respostas;
  final List<String> observacoes;
  final List<bool> evidenciasAdicionadas;
  final List<Uint8List?> evidenciasBytes;
  final List<ItemAdicional> itensAdicionais;

  const ResultadoChecklistScreen({
    super.key,
    required this.titulo,
    required this.setor,
    required this.supervisor,
    required this.totalPerguntas,
    required this.conformes,
    required this.naoConformes,
    required this.naoAplicaveis,
    required this.percentualConformidade,
    required this.percentualNC,
    required this.perguntas,
    required this.respostas,
    required this.observacoes,
    required this.evidenciasAdicionadas,
    required this.evidenciasBytes,
    required this.itensAdicionais,
  });

  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  Color corCriticidade(String criticidade) {
    if (criticidade == 'Crítica') {
      return const Color(0xFFC62828);
    }

    if (criticidade == 'Alta') {
      return const Color(0xFFEF6C00);
    }

    if (criticidade == 'Média') {
      return const Color(0xFFF9A825);
    }

    return const Color(0xFF6B7280);
  }

  void enviarParaAprovacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enviar relatório?'),
          content: const Text(
            'Após o envio, o relatório ficará com status "Aguardando aprovação do supervisor".',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                relatoriosPendentesAprovacao.add(
  RelatorioPendente(
    titulo: titulo,
    setor: setor,
    percentualConformidade: percentualConformidade,
    percentualNC: percentualNC,
    totalItensAdicionais: itensAdicionais.length,
    dataEnvio: DateTime.now(),
    perguntas: List<String>.from(perguntas),
    respostas: List<String?>.from(respostas),
    observacoes: List<String>.from(observacoes),
    evidenciasAdicionadas: List<bool>.from(evidenciasAdicionadas),
    evidenciasBytes: List<Uint8List?>.from(evidenciasBytes),
    itensAdicionais: List<ItemAdicional>.from(itensAdicionais),
  ),
);
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RelatorioEnviadoScreen(
                      titulo: titulo,
                      setor: setor,
                      supervisor: supervisor,
                      percentualConformidade: percentualConformidade,
                      percentualNC: percentualNC,
                      totalItensAdicionais: itensAdicionais.length,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00843D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalEvidencias =
        evidenciasAdicionadas.where((evidencia) => evidencia).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Resultado da Inspeção'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.analytics_outlined,
                    size: 72,
                    color: Color(0xFF00843D),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Setor: $setor',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Supervisor responsável: $supervisor',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4B5563),
                    ),
               ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF93C5FD),
                      ),
                    ),
                    child: const Text(
                      'Status: Finalizado - Pronto para envio',
                      style: TextStyle(
                        color: Color(0xFF1D4ED8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CardIndicador(
                  titulo: 'Conformidade',
                  valor: formatarPercentual(percentualConformidade),
                  cor: const Color(0xFF2E7D32),
                  icone: Icons.check_circle_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardIndicador(
                  titulo: 'NC',
                  valor: formatarPercentual(percentualNC),
                  cor: const Color(0xFFC62828),
                  icone: Icons.cancel_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ItemResumo(
                  titulo: 'Total de perguntas',
                  valor: totalPerguntas.toString(),
                  icone: Icons.list_alt,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Conformes',
                  valor: conformes.toString(),
                  icone: Icons.check,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Não conformes',
                  valor: naoConformes.toString(),
                  icone: Icons.close,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Não aplicáveis',
                  valor: naoAplicaveis.toString(),
                  icone: Icons.remove_circle_outline,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Evidências nas perguntas',
                  valor: totalEvidencias.toString(),
                  icone: Icons.photo_camera_outlined,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Itens adicionais',
                  valor: itensAdicionais.length.toString(),
                  icone: Icons.add_box_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Resumo das respostas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),

        const SizedBox(height: 12),

        ...List.generate(perguntas.length, (index) {
          final resposta = respostas[index] ?? 'Não respondida';
          final observacao = observacoes[index];
          final temEvidencia = evidenciasAdicionadas[index];
          final evidenciaBytes = evidenciasBytes[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pergunta ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00843D),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  perguntas[index],
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Resposta: $resposta',
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                  ),
                ),

                if (observacao.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Observação: $observacao',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],

                const SizedBox(height: 6),

                Text(
                  temEvidencia
                      ? 'Evidência: adicionada ✅'
                      : 'Evidência: não adicionada',
                  style: TextStyle(
                    color: temEvidencia
                        ? const Color(0xFF00843D)
                        : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                if (evidenciaBytes != null) ...[
                  const SizedBox(height: 8),

                  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, evidenciasBytes[index]!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      evidenciasBytes[index]!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
                ],
              ],
            ),
          );
        }),
      ],
    ),
  ),
),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Itens adicionais',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (itensAdicionais.isEmpty)
                    const Text(
                      'Nenhum item adicional registrado.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  if (itensAdicionais.isNotEmpty)
                    ...List.generate(itensAdicionais.length, (index) {
                      final item = itensAdicionais[index];
                      final cor = corCriticidade(item.criticidade);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item adicional ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00843D),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.descricao,
                              style: const TextStyle(
                                color: Color(0xFF1F2937),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Local: ${item.local}',
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Classificação: ${item.classificacao}',
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Criticidade: ${item.criticidade}',
                              style: TextStyle(
                                color: cor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Observação: ${item.observacao}',
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                              ),
                            ),
                            if (item.acaoRecomendada.trim().isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                'Ação recomendada: ${item.acaoRecomendada}',
                                style: const TextStyle(
                                  color: Color(0xFF4B5563),
                                ),
                              ),
                            ],
                            const SizedBox(height: 6),
                            Text(
                              item.evidenciaAdicionada
                                  ? 'Evidência: adicionada ✅'
                                  : 'Evidência: não adicionada',
                              style: TextStyle(
                                color: item.evidenciaAdicionada
                                    ? const Color(0xFF00843D)
                                    : const Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),

if (item.evidenciaBytes != null) ...[
  const SizedBox(height: 8),

  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, evidenciasBytes[index]!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      evidenciasBytes[index]!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
],
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: () => enviarParaAprovacao(context),
            icon: const Icon(Icons.send_outlined),
            label: const Text('Enviar para aprovação'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00843D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Voltar ao Início'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF00843D),
              side: const BorderSide(
                color: Color(0xFF00843D),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RelatorioEnviadoScreen extends StatelessWidget {
  final String titulo;
  final String setor;
  final String supervisor;
  final double percentualConformidade;
  final double percentualNC;
  final int totalItensAdicionais;

  const RelatorioEnviadoScreen({
    super.key,
    required this.titulo,
    required this.setor,
    required this.supervisor,
    required this.percentualConformidade,
    required this.percentualNC,
    required this.totalItensAdicionais,
  });

  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Relatório enviado'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
            const SizedBox(height: 32),
            const Icon(
              Icons.outgoing_mail,
              size: 88,
              color: Color(0xFF00843D),
            ),
            const SizedBox(height: 24),
            const Text(
              'Relatório enviado para aprovação',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'O supervisor responsável poderá revisar as respostas, observações, evidências e itens adicionais antes de aprovar ou recusar o relatório.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ItemResumo(
                    titulo: 'Status',
                    valor: 'Aguardando aprovação',
                    icone: Icons.hourglass_top,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'Checklist',
                    valor: titulo,
                    icone: Icons.assignment_outlined,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'Setor',
                    valor: setor,
                    icone: Icons.location_on_outlined,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'Supervisor',
                    valor: supervisor,
                    icone: Icons.supervisor_account_outlined,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'Conformidade',
                    valor: formatarPercentual(percentualConformidade),
                    icone: Icons.check_circle_outline,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'NC',
                    valor: formatarPercentual(percentualNC),
                    icone: Icons.cancel_outlined,
                  ),
                  const Divider(height: 1),
                  ItemResumo(
                    titulo: 'Itens adicionais',
                    valor: totalItensAdicionais.toString(),
                    icone: Icons.add_box_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.home_outlined),
              label: const Text('Voltar ao Início'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00843D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
 }
}

class RelatorioCompletoResultadosScreen extends StatelessWidget {
  final RelatorioHistorico relatorio;

  const RelatorioCompletoResultadosScreen({
    super.key,
    required this.relatorio,
  });

  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$ano $hora:$minuto';
  }

  Color corCriticidade(String criticidade) {
    if (criticidade == 'Crítica') {
      return const Color(0xFFC62828);
    }

    if (criticidade == 'Alta') {
      return const Color(0xFFEF6C00);
    }

    if (criticidade == 'Média') {
      return const Color(0xFFF9A825);
    }

    return const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    final bool recusado = relatorio.status == 'Recusado';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Relatório completo'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    relatorio.titulo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Setor: ${relatorio.setor}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${relatorio.status}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: recusado
                          ? const Color(0xFFC62828)
                          : const Color(0xFF00843D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enviado em: ${formatarData(relatorio.dataEnvio)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Decisão em: ${formatarData(relatorio.dataDecisao)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                  if (recusado && relatorio.motivoRecusa != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Motivo da recusa: ${relatorio.motivoRecusa}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFC62828),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CardIndicador(
                  titulo: 'Conformidade',
                  valor: formatarPercentual(relatorio.percentualConformidade),
                  cor: const Color(0xFF2E7D32),
                  icone: Icons.check_circle_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardIndicador(
                  titulo: 'NC',
                  valor: formatarPercentual(relatorio.percentualNC),
                  cor: const Color(0xFFC62828),
                  icone: Icons.cancel_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            'Respostas do checklist',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          ...List.generate(relatorio.perguntas.length, (index) {
            final pergunta = relatorio.perguntas[index];
            final resposta = relatorio.respostas[index] ?? 'Não respondida';
            final observacao = relatorio.observacoes[index];
            final temEvidencia = relatorio.evidenciasAdicionadas[index];
            final evidenciaBytes = relatorio.evidenciasBytes[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pergunta ${index + 1}',
                    style: const TextStyle(
                      color: Color(0xFF00843D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pergunta,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Resposta: $resposta',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  if (observacao.trim().isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Observação: $observacao',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    temEvidencia
                        ? 'Evidência: adicionada ✅'
                        : 'Evidência: não adicionada',
                    style: TextStyle(
                      color: temEvidencia
                          ? const Color(0xFF00843D)
                          : const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (evidenciaBytes != null) ...[
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        abrirImagemGrande(context, evidenciaBytes);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          evidenciaBytes,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            'Itens adicionais',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          if (relatorio.itensAdicionais.isEmpty)
            const Text(
              'Nenhum item adicional registrado.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),

          if (relatorio.itensAdicionais.isNotEmpty)
            ...List.generate(relatorio.itensAdicionais.length, (index) {
              final item = relatorio.itensAdicionais[index];
              final cor = corCriticidade(item.criticidade);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item adicional ${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFF00843D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.descricao,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Local: ${item.local}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Classificação: ${item.classificacao}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Criticidade: ${item.criticidade}',
                      style: TextStyle(
                        color: cor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Observação: ${item.observacao}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    if (item.acaoRecomendada.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Ação recomendada: ${item.acaoRecomendada}',
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      item.evidenciaAdicionada
                          ? 'Evidência: adicionada ✅'
                          : 'Evidência: não adicionada',
                      style: TextStyle(
                        color: item.evidenciaAdicionada
                            ? const Color(0xFF00843D)
                            : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.evidenciaBytes != null) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          abrirImagemGrande(context, item.evidenciaBytes!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            item.evidenciaBytes!,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class ResultadosScreen extends StatelessWidget {
  const ResultadosScreen({super.key});

  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$ano $hora:$minuto';
  }

  double calcularMediaConformidade() {
    final valores = <double>[
      ...relatoriosPendentesAprovacao.map(
        (relatorio) => relatorio.percentualConformidade,
      ),
      ...relatoriosAprovados.map(
        (relatorio) => relatorio.percentualConformidade,
      ),
      ...relatoriosRecusados.map(
        (relatorio) => relatorio.percentualConformidade,
      ),
    ];

    if (valores.isEmpty) {
      return 0;
    }

    final soma = valores.reduce((a, b) => a + b);
    return soma / valores.length;
  }

  double calcularMediaNC() {
    final valores = <double>[
      ...relatoriosPendentesAprovacao.map(
        (relatorio) => relatorio.percentualNC,
      ),
      ...relatoriosAprovados.map(
        (relatorio) => relatorio.percentualNC,
      ),
      ...relatoriosRecusados.map(
        (relatorio) => relatorio.percentualNC,
      ),
    ];

    if (valores.isEmpty) {
      return 0;
    }

    final soma = valores.reduce((a, b) => a + b);
    return soma / valores.length;
  }

  int calcularTotalItensAdicionais() {
    final totalPendentes = relatoriosPendentesAprovacao.fold<int>(
      0,
      (total, relatorio) => total + relatorio.totalItensAdicionais,
    );

    final totalAprovados = relatoriosAprovados.fold<int>(
      0,
      (total, relatorio) => total + relatorio.totalItensAdicionais,
    );

    final totalRecusados = relatoriosRecusados.fold<int>(
      0,
      (total, relatorio) => total + relatorio.totalItensAdicionais,
    );

    return totalPendentes + totalAprovados + totalRecusados;
  }

  Widget construirCardPendente(RelatorioPendente relatorio) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            relatorio.titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Setor: ${relatorio.setor}',
            style: const TextStyle(
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Status: Aguardando aprovação',
            style: TextStyle(
              color: Color(0xFF1D4ED8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Conformidade: ${formatarPercentual(relatorio.percentualConformidade)}',
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'NC: ${formatarPercentual(relatorio.percentualNC)}',
            style: const TextStyle(
              color: Color(0xFFC62828),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Itens adicionais: ${relatorio.totalItensAdicionais}',
            style: const TextStyle(
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Enviado em: ${formatarData(relatorio.dataEnvio)}',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget construirCardHistorico(BuildContext context, RelatorioHistorico relatorio) {
    final bool recusado = relatorio.status == 'Recusado';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            relatorio.titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Setor: ${relatorio.setor}',
            style: const TextStyle(
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Status: ${relatorio.status}',
            style: TextStyle(
              color: recusado
                  ? const Color(0xFFC62828)
                  : const Color(0xFF00843D),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Conformidade: ${formatarPercentual(relatorio.percentualConformidade)}',
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'NC: ${formatarPercentual(relatorio.percentualNC)}',
            style: const TextStyle(
              color: Color(0xFFC62828),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Itens adicionais: ${relatorio.totalItensAdicionais}',
            style: const TextStyle(
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Enviado em: ${formatarData(relatorio.dataEnvio)}',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Decisão em: ${formatarData(relatorio.dataDecisao)}',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),
          if (recusado && relatorio.motivoRecusa != null) ...[
            const SizedBox(height: 8),
            Text(
              'Motivo da recusa: ${relatorio.motivoRecusa}',
              style: const TextStyle(
                color: Color(0xFFC62828),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RelatorioCompletoResultadosScreen(
                    relatorio: relatorio,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.visibility_outlined),
            label: const Text('Abrir relatório completo'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF00843D),
              side: const BorderSide(
                color: Color(0xFF00843D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPendentes = relatoriosPendentesAprovacao.length;
    final totalAprovados = relatoriosAprovados.length;
    final totalRecusados = relatoriosRecusados.length;
    final totalRelatorios = totalPendentes + totalAprovados + totalRecusados;

    final mediaConformidade = calcularMediaConformidade();
    final mediaNC = calcularMediaNC();
    final totalItensAdicionais = calcularTotalItensAdicionais();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Resultados'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ItemResumo(
                  titulo: 'Total de relatórios',
                  valor: totalRelatorios.toString(),
                  icone: Icons.assignment_outlined,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Aguardando aprovação',
                  valor: totalPendentes.toString(),
                  icone: Icons.hourglass_top,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Aprovados',
                  valor: totalAprovados.toString(),
                  icone: Icons.check_circle_outline,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Recusados',
                  valor: totalRecusados.toString(),
                  icone: Icons.cancel_outlined,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Itens adicionais',
                  valor: totalItensAdicionais.toString(),
                  icone: Icons.add_box_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CardIndicador(
                  titulo: 'Conformidade média',
                  valor: formatarPercentual(mediaConformidade),
                  cor: const Color(0xFF2E7D32),
                  icone: Icons.check_circle_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardIndicador(
                  titulo: 'NC média',
                  valor: formatarPercentual(mediaNC),
                  cor: const Color(0xFFC62828),
                  icone: Icons.cancel_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            'Pendentes',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          if (relatoriosPendentesAprovacao.isEmpty)
            const Text(
              'Nenhum relatório pendente.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          if (relatoriosPendentesAprovacao.isNotEmpty)
            ...relatoriosPendentesAprovacao.map(construirCardPendente),

          const SizedBox(height: 20),

          const Text(
            'Aprovados',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          if (relatoriosAprovados.isEmpty)
            const Text(
              'Nenhum relatório aprovado.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          if (relatoriosAprovados.isNotEmpty)
           ...relatoriosAprovados.map(
          (relatorio) => construirCardHistorico(context, relatorio),
          ),

          const SizedBox(height: 20),

          const Text(
            'Recusados',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          if (relatoriosRecusados.isEmpty)
            const Text(
              'Nenhum relatório recusado.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          if (relatoriosRecusados.isNotEmpty)
           ...relatoriosRecusados.map(
          (relatorio) => construirCardHistorico(context, relatorio),
         ),
        ],
      ),
    );
  }
}

class DetalheRelatorioSupervisorScreen extends StatelessWidget {
  final RelatorioPendente relatorio;
  final VoidCallback onAprovar;
  final VoidCallback onRecusar;

  const DetalheRelatorioSupervisorScreen({
    super.key,
    required this.relatorio,
    required this.onAprovar,
    required this.onRecusar,
  });

  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$ano $hora:$minuto';
  }

  Color corCriticidade(String criticidade) {
    if (criticidade == 'Crítica') {
      return const Color(0xFFC62828);
    }

    if (criticidade == 'Alta') {
      return const Color(0xFFEF6C00);
    }

    if (criticidade == 'Média') {
      return const Color(0xFFF9A825);
    }

    return const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    final totalEvidencias = relatorio.evidenciasAdicionadas
        .where((evidencia) => evidencia)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Relatório para Aprovação'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    relatorio.titulo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Setor: ${relatorio.setor}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enviado em: ${formatarData(relatorio.dataEnvio)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF93C5FD),
                      ),
                    ),
                    child: const Text(
                      'Status: Aguardando aprovação',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1D4ED8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CardIndicador(
                  titulo: 'Conformidade',
                  valor: formatarPercentual(relatorio.percentualConformidade),
                  cor: const Color(0xFF2E7D32),
                  icone: Icons.check_circle_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardIndicador(
                  titulo: 'NC',
                  valor: formatarPercentual(relatorio.percentualNC),
                  cor: const Color(0xFFC62828),
                  icone: Icons.cancel_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ItemResumo(
                  titulo: 'Total de perguntas',
                  valor: relatorio.perguntas.length.toString(),
                  icone: Icons.list_alt,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Evidências nas perguntas',
                  valor: totalEvidencias.toString(),
                  icone: Icons.photo_camera_outlined,
                ),
                const Divider(height: 1),
                ItemResumo(
                  titulo: 'Itens adicionais',
                  valor: relatorio.itensAdicionais.length.toString(),
                  icone: Icons.add_box_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Respostas do checklist',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          ...List.generate(relatorio.perguntas.length, (index) {
            final pergunta = relatorio.perguntas[index];
            final resposta = relatorio.respostas[index] ?? 'Não respondida';
            final observacao = relatorio.observacoes[index];
            final temEvidencia = relatorio.evidenciasAdicionadas[index];
            final evidenciaBytes = relatorio.evidenciasBytes[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pergunta ${index + 1}',
                    style: const TextStyle(
                      color: Color(0xFF00843D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pergunta,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Resposta: $resposta',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  if (observacao.trim().isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Observação: $observacao',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    temEvidencia
                        ? 'Evidência: adicionada ✅'
                        : 'Evidência: não adicionada',
                    style: TextStyle(
                      color: temEvidencia
                          ? const Color(0xFF00843D)
                          : const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  if (evidenciaBytes != null) ...[
  const SizedBox(height: 8),

  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, relatorio.evidenciasBytes[index]!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      relatorio.evidenciasBytes[index]!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
],
                ],
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            'Itens adicionais',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          if (relatorio.itensAdicionais.isEmpty)
            const Text(
              'Nenhum item adicional registrado.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),

          if (relatorio.itensAdicionais.isNotEmpty)
            ...List.generate(relatorio.itensAdicionais.length, (index) {
              final item = relatorio.itensAdicionais[index];
              final cor = corCriticidade(item.criticidade);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item adicional ${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFF00843D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.descricao,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Local: ${item.local}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Classificação: ${item.classificacao}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Criticidade: ${item.criticidade}',
                      style: TextStyle(
                        color: cor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Observação: ${item.observacao}',
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    if (item.acaoRecomendada.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Ação recomendada: ${item.acaoRecomendada}',
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      item.evidenciaAdicionada
                          ? 'Evidência: adicionada ✅'
                          : 'Evidência: não adicionada',
                      style: TextStyle(
                        color: item.evidenciaAdicionada
                            ? const Color(0xFF00843D)
                            : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

if (item.evidenciaBytes != null) ...[
  const SizedBox(height: 8),
  
  GestureDetector(
  onTap: () {
    abrirImagemGrande(context, item.evidenciaBytes!);
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.memory(
      item.evidenciaBytes!,
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
],
                  ],
                ),
              );
            }),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: onAprovar,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Aprovar relatório'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00843D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: onRecusar,
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Recusar relatório'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFC62828),
              side: const BorderSide(
                color: Color(0xFFC62828),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class SupervisorPanelScreen extends StatefulWidget {
  const SupervisorPanelScreen({super.key});

  @override
  State<SupervisorPanelScreen> createState() {
    return _SupervisorPanelScreenState();
  }
}

class _SupervisorPanelScreenState extends State<SupervisorPanelScreen> {
  String formatarPercentual(double valor) {
    return '${valor.toStringAsFixed(1)}%';
  }

  String formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$ano $hora:$minuto';
  }

  void aprovarRelatorio(int index) {
  if (index < 0 || index >= relatoriosPendentesAprovacao.length) {
    return;
  }

  final relatorio = relatoriosPendentesAprovacao[index];

  Navigator.pop(context);

  setState(() {
    relatoriosAprovados.add(
      RelatorioHistorico(
        titulo: relatorio.titulo,
        setor: relatorio.setor,
        percentualConformidade: relatorio.percentualConformidade,
        percentualNC: relatorio.percentualNC,
        totalItensAdicionais: relatorio.totalItensAdicionais,
        dataEnvio: relatorio.dataEnvio,
        dataDecisao: DateTime.now(),
        status: 'Aprovado',
        perguntas: List<String>.from(relatorio.perguntas),
        respostas: List<String?>.from(relatorio.respostas),
        observacoes: List<String>.from(relatorio.observacoes),
        evidenciasAdicionadas: List<bool>.from(relatorio.evidenciasAdicionadas),
        evidenciasBytes: List<Uint8List?>.from(relatorio.evidenciasBytes),
        itensAdicionais: List<ItemAdicional>.from(relatorio.itensAdicionais),
      ),
    );

    relatoriosPendentesAprovacao.removeAt(index);
    relatoriosAprovadosHoje++;
  });

  Future.delayed(const Duration(milliseconds: 150), () {
    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Relatório aprovado'),
          content: Text(
            'O relatório "${relatorio.titulo}" foi aprovado com sucesso.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Voltar ao painel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00843D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Voltar ao início'),
            ),
          ],
        );
      },
    );
  });
}

void abrirDialogRecusa(int index) {
  if (index < 0 || index >= relatoriosPendentesAprovacao.length) {
    return;
  }

  final relatorio = relatoriosPendentesAprovacao[index];
  final TextEditingController motivoController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Recusar relatório'),
        content: TextField(
          controller: motivoController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Motivo da recusa',
            hintText: 'Informe o motivo da recusa do relatório',
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF00843D),
                width: 1.8,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final motivo = motivoController.text.trim();

              if (motivo.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Informe o motivo da recusa antes de continuar.',
                    ),
                  ),
                );
                return;
              }

              Navigator.pop(dialogContext);

              setState(() {
  final existeRelatorio =
      index >= 0 && index < relatoriosPendentesAprovacao.length;

  if (existeRelatorio) {
    final relatorioRecusado = relatoriosPendentesAprovacao[index];

    relatoriosRecusados.add(
      RelatorioHistorico(
        titulo: relatorioRecusado.titulo,
        setor: relatorioRecusado.setor,
        percentualConformidade: relatorioRecusado.percentualConformidade,
        percentualNC: relatorioRecusado.percentualNC,
        totalItensAdicionais: relatorioRecusado.totalItensAdicionais,
        dataEnvio: relatorioRecusado.dataEnvio,
        dataDecisao: DateTime.now(),
        status: 'Recusado',
        motivoRecusa: motivo,
        perguntas: List<String>.from(relatorioRecusado.perguntas),
        respostas: List<String?>.from(relatorioRecusado.respostas),
        observacoes: List<String>.from(relatorioRecusado.observacoes),
        evidenciasAdicionadas: List<bool>.from(relatorioRecusado.evidenciasAdicionadas),
        evidenciasBytes: List<Uint8List?>.from(relatorioRecusado.evidenciasBytes),
        itensAdicionais: List<ItemAdicional>.from(relatorioRecusado.itensAdicionais),
      ),
    );

    relatoriosPendentesAprovacao.removeAt(index);
    relatoriosRecusadosHoje++;
  }
});

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Relatório "${relatorio.titulo}" recusado. Motivo: $motivo',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmar recusa'),
          ),
        ],
      );
    },
  );
}

void abrirRelatorio(int index) {
  if (index < 0 || index >= relatoriosPendentesAprovacao.length) {
    return;
  }

  final relatorio = relatoriosPendentesAprovacao[index];

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetalheRelatorioSupervisorScreen(
        relatorio: relatorio,
        onAprovar: () {
          aprovarRelatorio(index);
        },
        onRecusar: () {
          Navigator.pop(context);

          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) {
              abrirDialogRecusa(index);
            }
          });
        },
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final relatorios = relatoriosPendentesAprovacao;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Painel do Supervisor'),
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo do Supervisor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Relatórios aguardando aprovação: ${relatorios.length}',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Relatórios aprovados hoje: $relatoriosAprovadosHoje',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Relatórios recusados hoje: $relatoriosRecusadosHoje',
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Aguardando aprovação',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 12),

          if (relatorios.isEmpty)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Nenhum relatório aguardando aprovação no momento.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                  ),
                ),
              ),
            ),

          if (relatorios.isNotEmpty)
            ...List.generate(relatorios.length, (index) {
              final relatorio = relatorios[index];
              final dataFormatada = formatarData(relatorio.dataEnvio);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        relatorio.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Setor: ${relatorio.setor}',
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Status: Aguardando aprovação',
                        style: TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Conformidade: ${formatarPercentual(relatorio.percentualConformidade)}',
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NC: ${formatarPercentual(relatorio.percentualNC)}',
                        style: const TextStyle(
                          color: Color(0xFFC62828),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Itens adicionais: ${relatorio.totalItensAdicionais}',
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enviado em: $dataFormatada',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          abrirRelatorio(index);
                        },
                        icon: const Icon(Icons.visibility_outlined),
                        label: const Text('Abrir relatório'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00843D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class ControleBicasScreen extends StatefulWidget {
  const ControleBicasScreen({super.key});

  @override
  State<ControleBicasScreen> createState() => _ControleBicasScreenState();
}

class _ControleBicasScreenState extends State<ControleBicasScreen> {

  // ✅ Estado das bicas
  Map<String, String> estadoBicas = {}; 
 Map<String, DateTime?> dataEntradaBicas = {};
 Map<String, List<String>> historicoBicas = {};


  // ✅ Inicializar todas como livres
  @override
  void initState() {
    super.initState();

    final todasBicas = [
      '01R','02D','03D','04D','05D','06D','07D',
      '08C','09C','10C','11C','12C','13C','14C','15C','16C',
      '17B','18B','19B','20B','21B','22B','23B','24B',
      '25A','26A','27A','28A','29A','30A','31A'
    ];

    for (var bica in todasBicas) {
      estadoBicas[bica] = 'livre';
      dataEntradaBicas[bica] = null;
      historicoBicas[bica] = [];
    }
  }

  // ✅ Cor da bica
  Color corDaBica(String codigoBica) {
  final estado = estadoBicas[codigoBica];

  if (estado == 'cheia') {
    final dataEntrada = dataEntradaBicas[codigoBica];

    if (dataEntrada != null) {
     final horas = DateTime.now().difference(dataEntrada).inHours;

      if (horas >= 72) {
        return const Color(0xFFD32F2F); // vermelho
      }
    }

    return const Color(0xFFF9A825); // amarelo
  }

  return const Color(0xFFE8F5E9); // verde
}


String textoStatusBica(String codigoBica) {
  final estado = estadoBicas[codigoBica] ?? 'livre';

  if (estado == 'livre') {
    return 'Livre';
  }

  final dataEntrada = dataEntradaBicas[codigoBica];

  if (dataEntrada == null) {
    return 'Farelo';
  }

  final horas = DateTime.now().difference(dataEntrada).inHours;

  if (horas >= 72) {
    return 'Crítico ${horas}h';
  }

  return 'Farelo ${horas}h';
}

int totalComFarelo() {
  int total = 0;

  for (var estado in estadoBicas.values) {
    if (estado == 'cheia') {
      total++;
    }
  }

  return total;
}

int totalCriticas() {
  int total = 0;

  for (var bica in estadoBicas.keys) {
    if (estadoBicas[bica] == 'cheia') {
      final dataEntrada = dataEntradaBicas[bica];

      if (dataEntrada != null) {
        final horas = DateTime.now().difference(dataEntrada).inHours;

        if (horas >= 72) {
          total++;
        }
      }
    }
  }

  return total;
}

String formatarDataHora(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  final ano = data.year.toString();
  final hora = data.hour.toString().padLeft(2, '0');
  final minuto = data.minute.toString().padLeft(2, '0');

  return '$dia/$mes/$ano $hora:$minuto';
}

void abrirHistoricoBica(BuildContext context, String codigoBica) {
  final historico = historicoBicas[codigoBica] ?? [];

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('Histórico - Bica $codigoBica'),
        content: SizedBox(
          width: double.maxFinite,
          height: 320,
          child: historico.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum registro encontrado para esta bica.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                    ),
                  ),
                )
              : Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: historico.length,
                    itemBuilder: (context, index) {
                      final registro = historico[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Text(
                          registro,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4B5563),
                            height: 1.3,
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}

List<String> bicasDoSetor(String setor) {
  if (setor == 'D') {
    return ['01R','02D','03D','04D','05D','06D','07D'];
  }

  if (setor == 'C') {
    return ['08C','09C','10C','11C','12C','13C','14C','15C','16C'];
  }

  if (setor == 'B') {
    return ['17B','18B','19B','20B','21B','22B','23B','24B'];
  }

  return ['25A','26A','27A','28A','29A','30A','31A'];
}

  // ✅ Quadrado da bica (com clique)
  Widget construirQuadradoBica(BuildContext context, String codigoBica) {
    final estado = estadoBicas[codigoBica] ?? 'livre';

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Bica $codigoBica'),
              content: const Text('Selecione uma ação'),
              actions: [
 
              TextButton(
              onPressed: () {
              Navigator.pop(context);

              Future.delayed(const Duration(milliseconds: 150), () {
              if (mounted) {
              abrirHistoricoBica(context, codigoBica);
              }
              });
             },
              child: const Text('Ver histórico'),
        ),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),

                TextButton(
                onPressed: () {
                final agora = DateTime.now();

                setState(() {
                estadoBicas[codigoBica] = 'cheia';
                dataEntradaBicas[codigoBica] = agora;

                historicoBicas[codigoBica]?.add(
                'Entrada registrada em ${formatarDataHora(agora)}',
                );
              });

    Navigator.pop(context);
  },
  child: const Text('Registrar entrada'),
),

                TextButton(
  onPressed: () {
    final agora = DateTime.now();
    final entrada = dataEntradaBicas[codigoBica];

    setState(() {
      if (entrada != null) {
        final horas = agora.difference(entrada).inHours;

        historicoBicas[codigoBica]?.add(
          'Retirada registrada em ${formatarDataHora(agora)} | Tempo com farelo: ${horas}h',
        );
      } else {
        historicoBicas[codigoBica]?.add(
          'Retirada registrada em ${formatarDataHora(agora)} | Sem entrada anterior registrada',
        );
      }

      estadoBicas[codigoBica] = 'livre';
      dataEntradaBicas[codigoBica] = null;
     });

              Navigator.pop(context);
               },
               child: const Text('Registrar retirada'),
               ),
              ],  
            );
          },
        );
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: corDaBica(codigoBica),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00843D),
            width: 1.4,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              codigoBica,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            
            Text(
            textoStatusBica(codigoBica),
            textAlign: TextAlign.center,
            style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF4B5563),
             ),
         ),
          ],
        ),
      ),
    );
  }

  // ✅ Montar setor
  Widget construirSetor(BuildContext context, String setor) {
    final bicas = bicasDoSetor(setor);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Setor $setor',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bicas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return construirQuadradoBica(
                  context,
                  bicas[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Tela principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Bicas'),
        backgroundColor: const Color(0xFF00843D),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

Card(
  margin: const EdgeInsets.only(bottom: 16),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Indicadores do Armazém',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Text(
          'Bicas com farelo: ${totalComFarelo()}',
        ),

        const SizedBox(height: 6),

        Text(
          'Bicas críticas (≥72h): ${totalCriticas()}',
          style: const TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),

          construirSetor(context, 'D'),
          construirSetor(context, 'C'),
          construirSetor(context, 'B'),
          construirSetor(context, 'A'),
        ],
      ),
    );
  }
}

class CardIndicador extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color cor;
  final IconData icone;

  const CardIndicador({
    super.key,
    required this.titulo,
    required this.valor,
    required this.cor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(
              icone,
              color: cor,
              size: 34,
            ),
            const SizedBox(height: 10),
            Text(
              valor,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemResumo extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;

  const ItemResumo({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            color: const Color(0xFF00843D),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              titulo,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              valor,
              textAlign: TextAlign.right,
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoResposta extends StatelessWidget {
  final String texto;
  final bool selecionado;
  final Color cor;
  final VoidCallback onTap;

  const BotaoResposta({
    super.key,
    required this.texto,
    required this.selecionado,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(texto),
      selected: selecionado,
      selectedColor: cor.withAlpha(45),
      labelStyle: TextStyle(
        color: selecionado ? cor : const Color(0xFF374151),
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: selecionado ? cor : const Color(0xFFD1D5DB),
      ),
      onSelected: (_) {
        onTap();
      },
    );
  }
}