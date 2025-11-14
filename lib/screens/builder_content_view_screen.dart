import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/builder_io_service.dart';

/// Tela para visualizar um conteúdo específico do Builder.io
class BuilderContentViewScreen extends StatefulWidget {
  final BuilderContent content;

  const BuilderContentViewScreen({
    super.key,
    required this.content,
  });

  @override
  State<BuilderContentViewScreen> createState() => _BuilderContentViewScreenState();
}

class _BuilderContentViewScreenState extends State<BuilderContentViewScreen> {
  late final WebViewController _controller;
  final _builderService = BuilderIOService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    final previewUrl = _builderService.getPreviewUrl(widget.content.id);
    
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
      ..loadRequest(Uri.parse(previewUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.content.displayName),
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

