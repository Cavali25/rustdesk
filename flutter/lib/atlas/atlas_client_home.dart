import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hbb/atlas/atlas_theme.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/consts.dart';
import 'package:flutter_hbb/desktop/pages/connection_page.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:flutter_hbb/models/server_model.dart';
import 'package:provider/provider.dart';

/// Tela principal ultra-limpa da Variante A — Atlas Desk Cliente (1 via / Incoming-only).
/// Exibe apenas o necessario para o cliente receber suporte remoto da Atlas Soft.
class AtlasClientHome extends StatefulWidget {
  const AtlasClientHome({Key? key}) : super(key: key);

  @override
  State<AtlasClientHome> createState() => _AtlasClientHomeState();
}

class _AtlasClientHomeState extends State<AtlasClientHome> {
  bool _idCopied = false;
  bool _passCopied = false;

  Future<void> _copyId(String id) async {
    final clean = id.trim();
    if (clean.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: clean));
    showToast('ID copiado!');
    if (!mounted) return;
    setState(() => _idCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _idCopied = false);
    });
  }

  Future<void> _copyPassword(String pwd) async {
    final clean = pwd.trim();
    if (clean.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: clean));
    showToast('Senha copiada!');
    if (!mounted) return;
    setState(() => _passCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _passCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = AtlasTheme.background(context);
    final surface = AtlasTheme.surface(context);
    final border = AtlasTheme.border(context);
    final textPrimary = AtlasTheme.textPrimary(context);
    final textSecondary = AtlasTheme.textSecondary(context);
    final accent = AtlasTheme.accent(context);
    final gold = AtlasTheme.gold(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ChangeNotifierProvider.value(
      value: gFFI.serverModel,
      child: Container(
        color: bg,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Consumer<ServerModel>(
                builder: (context, model, _) {
                  final idText = model.serverId.text;
                  final passText = model.serverPasswd.text;
                  final showOneTime = model.approveMode != 'click' &&
                      model.verificationMethod != kUsePermanentPassword;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Cabecalho com icone oficial Atlas Soft
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/atlas_icon.png',
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Atlas Desk',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              Text(
                                'Suporte Remoto • Atlas Soft',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: gold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Card principal: Seu ID
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: gold.withOpacity(isDark ? 0.35 : 0.45),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(isDark ? 0.25 : 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SEU ID DE ACESSO',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: SelectableText(
                                    idText.isEmpty ? '...' : idText,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () => _copyId(idText),
                                  icon: Icon(
                                    _idCopied ? Icons.check : Icons.copy,
                                    size: 16,
                                  ),
                                  label: Text(_idCopied ? 'Copiado' : 'Copiar ID'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        _idCopied ? AtlasTheme.online(context) : accent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (showOneTime) ...[
                              Divider(height: 24, color: border),
                              Text(
                                'SENHA TEMPORÁRIA',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  color: textSecondary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: SelectableText(
                                      passText.isEmpty ? '••••••' : passText,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.0,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Copiar senha',
                                    onPressed: () => _copyPassword(passText),
                                    icon: Icon(
                                      _passCopied ? Icons.check : Icons.copy_outlined,
                                      size: 18,
                                      color: _passCopied
                                          ? AtlasTheme.online(context)
                                          : textSecondary,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Gerar nova senha',
                                    onPressed: () => bind.mainUpdateTemporaryPassword(),
                                    icon: Icon(
                                      Icons.refresh,
                                      size: 18,
                                      color: textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Instrucao clara ao operador
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: border),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.support_agent, size: 20, color: accent),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Informe o ID acima ao técnico da Atlas Soft para iniciar o atendimento.',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: textSecondary,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Barra de status de conexao
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: border),
                        ),
                        child: OnlineStatusWidget(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
