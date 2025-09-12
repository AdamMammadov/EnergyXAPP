// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  final double produced = 10.2;
  final double used = 6.1;
  final double balance = 4.1;

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double total = produced + used;
    final double usedPercent = used / total;
    final double producedPercent = produced / total;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Salam, Məhəmməd!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _StatCard(title: 'Bugünkü istehsal', value: '${produced.toStringAsFixed(1)} kWh')),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(title: 'Bugünkü istifadə', value: '${used.toStringAsFixed(1)} kWh')),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(title: 'Balans', value: '+${balance.toStringAsFixed(1)} kWh', highlight: true)),
            ],
          ),
          const SizedBox(height: 18),
          // Dairəvi progress (pie-like)
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(value: produced, color: const Color(0xFF00C853), radius: 60, title: '${(producedPercent*100).toStringAsFixed(0)}%'),
                          PieChartSectionData(value: used, color: const Color(0xFFFF7043), radius: 50, title: '${(usedPercent*100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('İstehsal — İstifadə', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(children: [ _legendDot(const Color(0xFF00C853)), const SizedBox(width:8), Text('İstehsal: ${produced} kWh') ]),
                        const SizedBox(height:6),
                        Row(children: [ _legendDot(const Color(0xFFFF7043)), const SizedBox(width:8), Text('İstifadə: ${used} kWh') ]),
                        const SizedBox(height:12),
                        Text('Sistem sizə paylaşım təklifi verə bilər.', style: TextStyle(color: Colors.grey.shade700)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enerji paylaş (demo)')));
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C853)),
                          child: const Text('Enerji paylaş'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color c) => Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool highlight;
  const _StatCard({required this.title, required this.value, this.highlight=false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: highlight ? const Color(0xFFC8F7C5) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:14.0,horizontal:12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
