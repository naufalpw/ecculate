import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SubsidiPage extends StatefulWidget {
  @override
  _SubsidiPageState createState() => _SubsidiPageState();
}

class _SubsidiPageState extends State<SubsidiPage> {
  final TextEditingController aPdController = TextEditingController();
  final TextEditingController bPdController = TextEditingController();
  final TextEditingController aPsController = TextEditingController();
  final TextEditingController bPsController = TextEditingController();
  final TextEditingController sController = TextEditingController();

  String hasil = '';
  String qesValue = '';
  String pesValue = '';
  double? Qe, Pe, Qes, Pes;

  void _reset() {
    aPdController.clear();
    bPdController.clear();
    aPsController.clear();
    bPsController.clear();
    sController.clear();
    setState(() {
      hasil = '';
      qesValue = '';
      pesValue = '';
      Qe = null;
      Pe = null;
      Qes = null;
      Pes = null;
    });
  }

String formatAngka(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
}


  void _hitung() {
    double? aPd = double.tryParse(aPdController.text);
    double? bPd = double.tryParse(bPdController.text);
    double? aPs = double.tryParse(aPsController.text);
    double? bPs = double.tryParse(bPsController.text);
    double? s = double.tryParse(sController.text);

    if ([aPd, bPd, aPs, bPs, s].contains(null)) {
      setState(() {
        hasil = 'Semua input wajib diisi dengan angka';
        qesValue = '';
        pesValue = '';
        Qe = null;
        Pe = null;
        Qes = null;
        Pes = null;
      });
      return;
    }

    double tempQe = (aPs! - aPd!) / (bPd! - bPs!);
    double tempPe = aPd + bPd * tempQe;

    double aPss = aPs - s!;
    double bPss = bPs!;
    double penyebut = bPd - bPss;

    if (penyebut == 0) {
      setState(() {
        hasil = 'Persamaan tidak menghasilkan nilai Qes (penyebut = 0)';
        qesValue = '';
        pesValue = '';
        Qe = null;
        Pe = null;
        Qes = null;
        Pes = null;
      });
      return;
    }

    double tempQes = (aPss - aPd) / penyebut;
    double tempPes = aPss + bPss * tempQes;

    if (tempQe < 0 || tempPe < 0 || tempQes < 0 || tempPes < 0) {
      setState(() {
        hasil = 'Nilai Qe, Pe, Qes, dan Pes tidak boleh negatif.\nPeriksa kembali input.';
        Qe = null;
        Pe = null;
        Qes = null;
        Pes = null;
        qesValue = '';
        pesValue = '';
      });
      return;
    }

    double sk = tempPe - tempPes;
    double sp = s - sk;
    double S = s * tempQes;

    setState(() {
      Qe = tempQe;
      Pe = tempPe;
      Qes = tempQes;
      Pes = tempPes;

      hasil =
          'FUNGSI SEBELUM SUBSIDI:\n\n'
          'Pd(Q) = ${formatAngka(aPd)} + ${formatAngka(bPd)}Q\n'
          'Ps(Q) = ${formatAngka(aPs)} + ${formatAngka(bPs)}Q\n\n'
          'Cari Qe dari Pd = Ps:\n'
          '${formatAngka(aPd)} + ${formatAngka(bPd)}Q = ${formatAngka(aPs)} + ${formatAngka(bPs)}Q\n'
          'Qe = (${formatAngka(aPs)} - ${formatAngka(aPd)}) / (${formatAngka(bPd)} - ${formatAngka(bPs)}) = ${formatAngka(Qe!)}\n'
          'Pe = ${formatAngka(aPd)} + ${formatAngka(bPd)} x ${formatAngka(Qe!)} = ${formatAngka(Pe!)}\n\n'
          '-------------------------\n\n'
          'FUNGSI SETELAH SUBSIDI:\n\n'
          'Pss(Q) = (${formatAngka(aPs)} - ${formatAngka(s)}) + ${formatAngka(bPs)}Q = ${formatAngka(aPss)} + ${formatAngka(bPss)}Q\n\n'
          'Cari Qes dari Pd = Pss:\n'
          '${formatAngka(aPd)} + ${formatAngka(bPd)}Q = ${formatAngka(aPss)} + ${formatAngka(bPss)}Q\n'
          'Qes = (${formatAngka(aPss)} - ${formatAngka(aPd)}) / (${formatAngka(bPd)} - ${formatAngka(bPss)}) = ${formatAngka(Qes!)}\n'
          'Pes = ${formatAngka(aPss)} + ${formatAngka(bPss)} x ${formatAngka(Qes!)} = ${formatAngka(Pes!)}\n\n'
          '-------------------------\n\n'
          'Keseimbangan Sebelum Subsidi:\nQe = ${formatAngka(Qe!)}\nPe = ${formatAngka(Pe!)}\n'
          '(Qe,Pe) = (${formatAngka(Qe!)},${formatAngka(Pe!)})\n\n'
          'Keseimbangan Setelah Subsidi:\nQes = ${formatAngka(Qes!)}\nPes = ${formatAngka(Pes!)}\n'
          '(Qes,Pes) = (${formatAngka(Qes!)},${formatAngka(Pes!)})\n\n'
          '-------------------------\n\n'
          'Subsidi Dinikmati Konsumen (sk):\n'
          'sk = Pe - Pes = ${formatAngka(Pe!)} - ${formatAngka(Pes!)} = ${formatAngka(sk)}\n\n'
          'Subsidi Diterima Produsen (sp):\n'
          'sp = s - sk = ${formatAngka(s)} - ${formatAngka(sk)} = ${formatAngka(sp)}\n\n'
          'Total Subsidi Pemerintah (S):\n'
          'S = s x Qes = ${formatAngka(s)} x ${formatAngka(Qes!)} = ${formatAngka(S)}';

      qesValue = formatAngka(Qes!);
      pesValue = formatAngka(Pes!);
    });
  }

  List<FlSpot> _getSpots(double a, double b) {
    List<FlSpot> spots = [];
    for (double q = 0; q <= (Qes ?? Qe ?? 10) + 5; q += 1) {
      double p = a + b * q;
      if (p >= 0) spots.add(FlSpot(q, p));
    }
    return spots;
  }

  @override
  void dispose() {
    aPdController.dispose();
    bPdController.dispose();
    aPsController.dispose();
    bPsController.dispose();
    sController.dispose();
    super.dispose();
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed, Color color) {
    return InkWell(
      onTap: onPressed,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 255, 184),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'VARIABEL SUBSIDI',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: const [
                  Text('KALKULATOR', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 24, color: Colors.deepOrange)),
                  SizedBox(height: 8),
                  Text('VARIABEL SUBSIDI', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Fungsi Permintaan (Pd): Pd = a + bQ', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
            _inputField('a (konstanta Pd)', aPdController),
            _inputField('b (koefisien Q Pd)', bPdController),
            const SizedBox(height: 10),
            const Text('Fungsi Penawaran (Ps): Ps = a + bQ', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
            _inputField('a (konstanta Ps)', aPsController),
            _inputField('b (koefisien Q Ps)', bPsController),
            const SizedBox(height: 10),
            _inputField('Besaran Subsidi per Unit (s)', sController),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildButton('HITUNG', _hitung, const Color.fromARGB(255, 59, 243, 65))),
                const SizedBox(width: 10),
                Expanded(child: _buildButton('RESET', _reset, Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
              ),
              child: Text(
                hasil.isNotEmpty ? hasil : 'Hasil :',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            if (Qe != null && Pe != null && Qes != null && Pes != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 280,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: (value, _) =>
                                    Text(value.toInt().toString()),
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: (value, _) =>
                                    Text(value.toInt().toString()),
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [FlSpot(Qes!, Pes!)],
                              isCurved: false,
                              color: const Color.fromARGB(255, 255, 6, 6),
                              barWidth: 0,
                              dotData: FlDotData(show: true),
                            ),
                            LineChartBarData(
                              spots: [FlSpot(Qe!, Pe!)],
                              isCurved: false,
                              color: Colors.blue,
                              barWidth: 0,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                          minX: 0,
                          maxX: max(Qe!, Qes!) + 10,
                          minY: 0,
                          maxY: max(Pe!, Pes!) + 10,
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                          lineTouchData: LineTouchData(enabled: true),
                          extraLinesData: ExtraLinesData(
                            extraLinesOnTop: true,
                            horizontalLines: [
                              HorizontalLine(
                                y: Pe!,
                                color: Colors.blue,
                                strokeWidth: 1,
                                dashArray: [4, 4],
                              ),
                              HorizontalLine(
                                y: Pes!,
                                color: const Color.fromARGB(255, 255, 12, 12),
                                strokeWidth: 1,
                                dashArray: [4, 4],
                              ),
                            ],
                            verticalLines: [
                              VerticalLine(
                                x: Qe!,
                                color: Colors.blue,
                                strokeWidth: 1,
                                dashArray: [4, 4],
                              ),
                              VerticalLine(
                                x: Qes!,
                                color: const Color.fromARGB(255, 255, 12, 12),
                                strokeWidth: 1,
                                dashArray: [4, 4],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.circle, size: 12, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            'Sebelum Subsidi',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.circle, size: 12, color: Color.fromARGB(255, 253, 17, 17)),
                          SizedBox(width: 4),
                          Text(
                            'Setelah Subsidi',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
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
}
