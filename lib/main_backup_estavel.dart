import 'package:flutter/material.dart';

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
      home: const HomeScreen(),
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

  const ItemAdicional({
    required this.descricao,
    required this.local,
    required this.classificacao,
    required this.criticidade,
    required this.observacao,
    required this.acaoRecomendada,
    required this.evidenciaAdicionada,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void abrirChecklists(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChecklistListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Inspect FSQR CNH'),
        centerTitle: true,
        backgroundColor: const Color(0xFF00843D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/FSQR_cargill.png',
              height: 90,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.fact_check_outlined,
                  size: 80,
                  color: Color(0xFF00843D),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Gestão de Checklists e Inspeções',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Organize inspeções por setor, acompanhe conformidades e registre não conformidades de forma prática.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => abrirChecklists(context),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Iniciar Checklist'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00843D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bar_chart),
              label: const Text('Ver Resultados'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF00843D),
                side: const BorderSide(
                  color: Color(0xFF00843D),
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'MVP 0 • Protótipo inicial',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 13,
              ),
            ),
          ],
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

  final List<ItemAdicional> itensAdicionais = [];

  @override
  void initState() {
    super.initState();

    respostas = List<String?>.filled(widget.perguntas.length, null);

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

  void alternarEvidencia(int index) {
    setState(() {
      evidenciasAdicionadas[index] = !evidenciasAdicionadas[index];
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
                  OutlinedButton.icon(
                    onPressed: () => alternarEvidencia(index),
                    icon: Icon(
                      evidenciaAdicionada
                          ? Icons.delete_outline
                          : Icons.add_a_photo_outlined,
                    ),
                    label: Text(
                      evidenciaAdicionada
                          ? 'Remover evidência'
                          : 'Adicionar foto/evidência',
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

class ItemAdicionalFormScreen extends StatefulWidget {
  const ItemAdicionalFormScreen({super.key});

  @override
  State<ItemAdicionalFormScreen> createState() {
    return _ItemAdicionalFormScreenState();
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
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      evidenciaAdicionada = !evidenciaAdicionada;
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
                        : 'Adicionar foto/evidência',
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const Spacer(),
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
    return ListTile(
      leading: Icon(
        icone,
        color: const Color(0xFF00843D),
      ),
      title: Text(titulo),
      trailing: Text(
        valor,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Color(0xFF1F2937),
        ),
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