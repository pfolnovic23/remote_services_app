import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/pjesma_models.dart';
import '../data/pjesma_service.dart';

class PjesmePage extends StatefulWidget {
  const PjesmePage({super.key});

  @override
  State<PjesmePage> createState() => _PjesmePageState();
}

class _PjesmePageState extends State<PjesmePage> {
  final PjesmaService _pjesmaService = PjesmaService(ApiClient());
  List<PjesmaModel> _pjesme = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPjesme();
  }

  Future<void> _loadPjesme() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final pjesme = await _pjesmaService.getPjesme();
      if (mounted) {
        setState(() {
          _pjesme = pjesme;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _showPjesmaDetail(PjesmaModel pjesma) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(pjesma.ime),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Grupa', pjesma.grupa),
            const SizedBox(height: 8),
            _buildDetailRow('Trajanje', pjesma.trajanje),
            const SizedBox(height: 8),
            _buildDetailRow('Godina', pjesma.godina.toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zatvori'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hrvatske Pjesme'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPjesme,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPjesme,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_pjesme.isEmpty) {
      return const Center(child: Text('Nema podataka'));
    }

    return RefreshIndicator(
      onRefresh: _loadPjesme,
      child: ListView.builder(
        itemCount: _pjesme.length,
        itemBuilder: (context, index) {
          final pjesma = _pjesme[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),
              title: Text(
                pjesma.ime,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.group, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        pjesma.grupa,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.timer, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        pjesma.trajanje,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pjesma.godina.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              onTap: () => _showPjesmaDetail(pjesma),
            ),
          );
        },
      ),
    );
  }
}
