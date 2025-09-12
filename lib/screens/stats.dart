 // ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String _range = 'Həftəlik';

  final List<double> _production = [8, 9, 10, 11, 12, 10, 9];
  final List<double> _consumption = [6, 7, 5, 8, 7, 6, 5];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistikalar',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Filtr (Həftəlik / Aylıq)
          Row(
            children: [
              ChoiceChip(
                label: const Text('Həftəlik'),
                selected: _range == 'Həftəlik',
                onSelected: (_) => setState(() => _range = 'Həftəlik'),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Aylıq'),
                selected: _range == 'Aylıq',
                onSelected: (_) => setState(() => _range = 'Aylıq'),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Qrafik
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: LineChart(_buildLineChart()),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Top paylaşım edən istifadəçilər
          Row(
            children: [
              _miniCard('Top paylaşım', 'B istifadəçisi'),
              const SizedBox(width: 8),
              _miniCard('İkinci', 'C istifadəçisi'),
              const SizedBox(width: 8),
              _miniCard('Üçüncü', 'D istifadəçisi'),
            ],
          ),
        ],
      ),
    );
  }

  LineChartData _buildLineChart() {
    final prodSpots = <FlSpot>[];
    final consSpots = <FlSpot>[];

    for (int i = 0; i < _production.length; i++) {
      prodSpots.add(FlSpot(i.toDouble(), _production[i]));
      consSpots.add(FlSpot(i.toDouble(), _consumption[i]));
    }

    return LineChartData(
      gridData: const FlGridData(show: true, horizontalInterval: 2),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (v, meta) {
              const labels = ['Pzt', 'Çrş', 'Cmt', 'Şə', 'C', 'Şb', 'B'];
              return Text(labels[v.toInt() % labels.length]);
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: prodSpots,
          isCurved: true,
          color: const Color(0xFF00C853),
          dotData: const FlDotData(show: false),
          barWidth: 3,
        ),
        LineChartBarData(
          spots: consSpots,
          isCurved: true,
          color: const Color(0xFFFF7043),
          dotData: const FlDotData(show: false),
          barWidth: 3,
        ),
      ],
    );
  }

  Widget _miniCard(String title, String subtitle) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
