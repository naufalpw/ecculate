import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PeQePage extends StatefulWidget {
  @override
  _PeQePageState createState() => _PeQePageState();
}

class _PeQePageState extends State<PeQePage> {
  final aPdController = TextEditingController();
  final bPdController = TextEditingController();
  final aPsController = TextEditingController();
  final bPsController = TextEditingController();

  String result = '';
  double? qe, pe;

void _hitungKeseimbangan() {
  double? aPd = double.tryParse(aPdController.text);
  double? bPd = double.tryParse(bPdController.text);
  double? aPs = double.tryParse(aPsController.text);
  double? bPs = double.tryParse(bPsController.text);

  if (aPd == null || bPd == null || aPs == null || bPs == null) {
    setState(() {
      result = 'Semua input harus diisi dengan angka!';
      qe = null;
      pe = null;
    });
    return;
  }

  double penyebut = bPd - bPs;
  if (penyebut == 0) {
    setState(() {
      result = 'Fungsi tidak memiliki titik potong (garis sejajar)';
      qe = null;
      pe = null;
    });
    return;
  }

  double tempQe = (aPs - aPd) / penyebut;
  double tempPe = aPd + bPd * tempQe;

  if (tempQe < 0 || tempPe < 0) {
    setState(() {
      result = 'Tidak ada titik keseimbangan valid\n(Qₑ atau Pₑ bernilai negatif)';
      qe = null;
      pe = null;
    });
    return;
  }

  qe = tempQe;
  pe = tempPe;

  setState(() {
    result = 'Qₑ = ${formatSmart(qe!)}\n'
        'Pₑ = ${formatSmart(pe!)}\n\n'
        'Titik Keseimbangan: (${formatSmart(qe!)}, ${formatSmart(pe!)})';
  });
}


  void _reset() {
    aPdController.clear();
    bPdController.clear();
    aPsController.clear();
    bPsController.clear();
    setState(() {
      result = '';
      qe = null;
      pe = null;
    });
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }



  LineChartBarData _titikKeseimbangan() {
    if (qe == null || pe == null) return LineChartBarData(spots: []);
    return LineChartBarData(
      spots: [FlSpot(qe!, pe!)],
      isCurved: false,
      color: Colors.black,
      barWidth: 0,
      dotData: FlDotData(
        show: true,
        getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
          radius: 6,
          color: Colors.black,
          strokeWidth: 2,
          strokeColor: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    aPdController.dispose();
    bPdController.dispose();
    aPsController.dispose();
    bPsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 255, 184),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'KALKULATOR Pₑ & Qₑ',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderBox(),
            const SizedBox(height: 20),
            const Text('Fungsi Permintaan (Pd)',
                style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
            _buildInput('a (konstanta Pd)', aPdController),
            _buildInput('b (koefisien Q pada Pd)', bPdController),
            const SizedBox(height: 12),
            const Text('Fungsi Penawaran (Ps)',
                style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
            _buildInput('a (konstanta Ps)', aPsController),
            _buildInput('b (koefisien Q pada Ps)', bPsController),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _button('HITUNG', _hitungKeseimbangan, const Color.fromARGB(255, 12, 211, 38))),
                const SizedBox(width: 10),
                Expanded(child: _button('RESET', _reset, Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            _buildResultBox(),
            const SizedBox(height: 24),
            if (qe != null && pe != null)
              Container(
                height: 300,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 5,
                              getTitlesWidget: (value, _) => Text(value.toInt().toString()),
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 5,
                              getTitlesWidget: (value, _) => Text(value.toInt().toString()),
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          _titikKeseimbangan(),
                        ],
                        minX: max(0, qe! - 10),
                        maxX: qe! + 10,
                        minY: max(0, pe! - 10),
                        maxY: pe! + 10,
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        lineTouchData: LineTouchData(enabled: true),
                        extraLinesData: ExtraLinesData(
                          extraLinesOnTop: true,
                          horizontalLines: [
                            HorizontalLine(y: pe!, color: Colors.black, strokeWidth: 1, dashArray: [4, 4]),
                          ],
                          verticalLines: [
                            VerticalLine(x: qe!, color: Colors.black, strokeWidth: 1, dashArray: [4, 4]),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Text(
                        'Qₑ, Pₑ',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: const [
          Text('MASUKKAN FUNGSI', style: TextStyle(
              fontFamily: 'PressStart2P', fontSize: 16, color: Colors.black)),
          SizedBox(height: 8),
          Text('Format: P = a + bQ', style: TextStyle(
              fontFamily: 'PressStart2P', fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildResultBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Text(
        result.isNotEmpty ? result : 'Hasil :',
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
      ),
    );
  }

  Widget _button(String label, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(3, 3))],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

String formatSmart(double value) {
  return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(3);
}
