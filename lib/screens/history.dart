 // ignore_for_file: curly_braces_in_flow_control_structures, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _rows = [
    {'date': '08.09.25', 'to': 'B istifadəçisi', 'amount': 2.0, 'status': '✅'},
    {'date': '07.09.25', 'to': 'C istifadəçisi', 'amount': 1.5, 'status': '✅'},
    {'date': '05.09.25', 'to': 'D istifadəçisi', 'amount': 0.8, 'status': '✅'},
  ];

  late List<Map<String, dynamic>> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_rows);
  }

  void _filterByDate(String query) {
    setState(() {
      if (query.isEmpty) {
        _filtered = List.from(_rows);
      } else {
        _filtered = _rows.where((r) => r['date'].toString().contains(query)).toList();
      }
    });
  }

  Future<void> _exportCSV() async {
    try {
      // CSV yarat
      final buffer = StringBuffer();
      buffer.writeln('Tarix,Kimə,Miqdar(kWh),Status');
      for (var r in _filtered) {
        buffer.writeln('${r['date']},${r['to']},${r['amount']},${r['status']}');
      }
      final csv = buffer.toString();

      // Faylı saxla
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/enerjix_history_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(csv);

      // Paylaş
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'EnerjiX Paylaşım Tarixçəsi (CSV)',
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xəta baş verdi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Paylaşım Tarixçəsi',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Tarixə görə axtar (örn: 08.09.25)',
            ),
            onChanged: _filterByDate,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Tarix')),
                  DataColumn(label: Text('Kimə')),
                  DataColumn(label: Text('Miqdar')),
                  DataColumn(label: Text('Status')),
                ],
                rows: _filtered.map((r) {
                  return DataRow(cells: [
                    DataCell(Text(r['date'])),
                    DataCell(Text(r['to'])),
                    DataCell(Text('${r['amount']} kWh')),
                    DataCell(Text(r['status'])),
                  ]);
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.file_download),
                  label: const Text('Export (CSV)'),
                  onPressed: _exportCSV,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
