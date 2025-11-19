import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/reper_models.dart';
import '../data/reper_service.dart';

class ReperDetailPage extends StatefulWidget {
  final int reperId;

  const ReperDetailPage({super.key, required this.reperId});

  @override
  State<ReperDetailPage> createState() => _ReperDetailPageState();
}

class _ReperDetailPageState extends State<ReperDetailPage> {
  final ReperService _reperService = ReperService(ApiClient());
  ReperModel? _reper;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadReper();
  }

  Future<void> _loadReper() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final reper = await _reperService.getReperById(widget.reperId);
      setState(() {
        _reper = reper;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reper #${widget.reperId}'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Učitavanje repera...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorView();
    }

    if (_reper == null) {
      return _buildNotFoundView();
    }

    return _buildReperDetails();
  }

  Widget _buildErrorView() {
    final isNotFound = _errorMessage!.contains('404') ||
        _errorMessage!.contains('Not Found') ||
        _errorMessage!.contains('Cannot GET');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNotFound ? Icons.person_off : Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              isNotFound ? 'Reper nije pronađen' : 'Greška pri učitavanju',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isNotFound
                  ? 'Reper sa ID brojem ${widget.reperId} ne postoji u bazi.'
                  : 'Došlo je do greške prilikom dohvaćanja podataka.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadReper,
              icon: const Icon(Icons.refresh),
              label: const Text('Pokušaj ponovo'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Natrag'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_off,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              'Reper nije pronađen',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Reper sa ID brojem ${widget.reperId} ne postoji.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Natrag'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReperDetails() {
    final reper = _reper!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Large avatar
          Hero(
            tag: 'reper_${reper.id}',
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
              child: Text(
                reper.ime[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Main info card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      reper.ime,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow(
                    context,
                    icon: Icons.badge,
                    label: 'Pravo ime',
                    value: reper.pravoIme,
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.group,
                    label: 'Grupa',
                    value: reper.grupa,
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.location_city,
                    label: 'Grad',
                    value: reper.grad,
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    context,
                    icon: Icons.numbers,
                    label: 'ID',
                    value: reper.id.toString(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // API info card
          Card(
            color: Colors.green.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GET /reperi/${widget.reperId}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Uspješno dohvaćeno',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Back button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Natrag'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
