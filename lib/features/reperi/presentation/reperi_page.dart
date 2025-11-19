import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/reper_models.dart';
import '../data/reper_service.dart';

class ReperiPage extends StatefulWidget {
  const ReperiPage({super.key});

  @override
  State<ReperiPage> createState() => _ReperiPageState();
}

class _ReperiPageState extends State<ReperiPage> {
  final ReperService _reperService = ReperService(ApiClient());
  List<ReperModel> _reperi = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadReperi();
  }

  Future<void> _loadReperi() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final reperi = await _reperService.getReperi();
      if (mounted) {
        setState(() {
          _reperi = reperi;
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

  void _showReperDetail(ReperModel reper) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(reper.ime),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Pravo ime', reper.pravoIme),
            const SizedBox(height: 8),
            _buildDetailRow('Grupa', reper.grupa),
            const SizedBox(height: 8),
            _buildDetailRow('Grad', reper.grad),
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
        title: const Text('Hrvatski Reperi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadReperi,
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
              onPressed: _loadReperi,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_reperi.isEmpty) {
      return const Center(child: Text('Nema podataka'));
    }

    return RefreshIndicator(
      onRefresh: _loadReperi,
      child: ListView.builder(
        itemCount: _reperi.length,
        itemBuilder: (context, index) {
          final reper = _reperi[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  reper.ime[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                reper.ime,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reper.pravoIme),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.group, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        reper.grupa,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        reper.grad,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () => _showReperDetail(reper),
            ),
          );
        },
      ),
    );
  }
}
