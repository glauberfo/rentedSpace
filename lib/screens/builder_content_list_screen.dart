import 'package:flutter/material.dart';
import '../services/builder_io_service.dart';
import 'builder_content_view_screen.dart';

/// Tela que lista todos os conteúdos criados no Builder.io
class BuilderContentListScreen extends StatefulWidget {
  const BuilderContentListScreen({super.key});

  @override
  State<BuilderContentListScreen> createState() => _BuilderContentListScreenState();
}

class _BuilderContentListScreenState extends State<BuilderContentListScreen> {
  final _builderService = BuilderIOService();
  List<BuilderContent> _contents = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContents();
  }

  Future<void> _loadContents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final contents = await _builderService.getAllContent();
      setState(() {
        _contents = contents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _navigateToContent(BuilderContent content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuilderContentViewScreen(content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conteúdos do Builder.io'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadContents,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar conteúdos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadContents,
                child: const Text('Tentar novamente'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Certifique-se de configurar sua API Key em:\nlib/config/builder_io_config.dart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (_contents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum conteúdo encontrado',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Crie conteúdos no Builder.io para vê-los aqui',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadContents,
              child: const Text('Atualizar'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadContents,
      child: ListView.builder(
        itemCount: _contents.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final content = _contents[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: content.previewImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        content.previewImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.article);
                        },
                      ),
                    )
                  : const Icon(Icons.article),
              title: Text(content.displayName),
              subtitle: content.lastUpdated != null
                  ? Text('Atualizado: ${_formatDate(content.lastUpdated!)}')
                  : null,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _navigateToContent(content),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

