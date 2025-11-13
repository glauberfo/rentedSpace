import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Tela para exibir o Builder.io em uma WebView
/// 
/// Para usar:
/// 1. Obtenha sua API Key do Builder.io em: https://builder.io
/// 2. Substitua 'YOUR_BUILDER_API_KEY' pela sua chave
/// 3. Substitua 'YOUR_MODEL_NAME' pelo nome do seu modelo no Builder.io
class BuilderIOScreen extends StatefulWidget {
  const BuilderIOScreen({super.key});

  @override
  State<BuilderIOScreen> createState() => _BuilderIOScreenState();
}

class _BuilderIOScreenState extends State<BuilderIOScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // Configurar o WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar: ${error.description}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://builder.io'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Builder.io'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
            tooltip: 'Recarregar',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

