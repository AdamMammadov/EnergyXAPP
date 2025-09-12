 // ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AiOfferScreen extends StatefulWidget {
  const AiOfferScreen({super.key});

  @override
  _AiOfferScreenState createState() => _AiOfferScreenState();
}

class _AiOfferScreenState extends State<AiOfferScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  String _status = 'Gözlənilir';

  @override
  void initState() {
    super.initState();
    // Kiçik animasiya effekti üçün
    Future.delayed(
      const Duration(milliseconds: 400),
      () => setState(() => _visible = true),
    );
  }

  void _confirm() {
    setState(() => _status = 'Təsdiq edildi');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('2 kWh B istifadəçisinə paylaşıldı (demo).'),
      ),
    );
  }

  void _decline() {
    setState(() => _status = 'Rədd edildi');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: _visible ? 1.0 : 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enerji paylaşımı üçün təklifiniz var!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Təklif kartı
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'AI sistemimizə görə sizin artıq enerjiniz var. '
                      'Yaxınlığınızda yerləşən B istifadəçisinin 2 kWh ehtiyacı var. '
                      'Paylaşmaq istəyirsinizmi?',
                    ),
                    const SizedBox(height: 16),

                    // Avatarlar və ox
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(child: Text('A')),
                            SizedBox(height: 4),
                            Text('Siz'),
                          ],
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward,
                            color: Color(0xFF00C853), size: 28),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            CircleAvatar(child: Text('B')),
                            SizedBox(height: 4),
                            Text('B istifadəçisi'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Düymələr
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _confirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00C853),
                            ),
                            child: const Text('Təsdiq et'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _decline,
                            child: const Text(
                              'Rədd et',
                              style: TextStyle(color: Color(0xFF263238)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Status + tarixçə linki
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Təklif statusu: $_status',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const OfferHistoryScreen(),
                              ),
                            );
                          },
                          child: const Text('Təklif tarixçəsi'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> history = const [
    {
      'date': '08.09.25',
      'to': 'B istifadəçisi',
      'amount': '2 kWh',
      'status': '✅'
    },
    {
      'date': '07.09.25',
      'to': 'C istifadəçisi',
      'amount': '1.5 kWh',
      'status': '✅'
    },
  ];

  const OfferHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Təklif tarixçəsi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (ctx, i) {
          final it = history[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(it['to']!.substring(0, 1))),
              title: Text('${it['to']} — ${it['amount']}'),
              subtitle: Text(it['date']!),
              trailing: Text(it['status']!),
            ),
          );
        },
      ),
    );
  }
}
