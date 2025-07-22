import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PajakSpesifikPage extends StatefulWidget {
  @override
  _PajakSpesifikPageState createState() => _PajakSpesifikPageState();
}

class _PajakSpesifikPageState extends State<PajakSpesifikPage> {
  final TextEditingController aPdController = TextEditingController();
  final TextEditingController bPdController = TextEditingController();
  final TextEditingController aPsController = TextEditingController();
  final TextEditingController bPsController = TextEditingController();
  final TextEditingController tController = TextEditingController();

  String hasil = '';
  String qetValue = '';
  String petValue = '';
  double? Qe, Pe, Qet, Pet;

  void _reset() {
    aPdController.clear();
    bPdController.clear();
    aPsController.clear();
    bPsController.clear();
    tController.clear();
    setState(() {
      hasil = '';
      qetValue = '';
      petValue = '';
      Qe = null;
      Pe = null;
      Qet = null;
      Pet = null;
    });
  }

String formatAngka(double value) {
  // Jika bilangan bulat, tampilkan tanpa desimal
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
    double? t = double.tryParse(tController.text);

    if ([aPd, bPd, aPs, bPs, t].contains(null)) {
      setState(() {
        hasil = 'Semua input wajib diisi dengan angka';
        qetValue = '';
        petValue = '';
        Qe = null;
        Pe = null;
        Qet = null;
        Pet = null;
      });
      return;
    }

    double tempQe = (aPs! - aPd!) / (bPd! - bPs!);
    double tempPe = aPd + bPd * tempQe;

    double aPst = aPs + t!;
    double bPst = bPs!;
    double penyebut = bPd - bPst;

    if (penyebut == 0) {
      setState(() {
        hasil = 'Persamaan tidak menghasilkan nilai Qet (penyebut = 0)';
        qetValue = '';
        petValue = '';
        Qe = null;
        Pe = null;
        Qet = null;
        Pet = null;
      });
      return;
    }

    double tempQet = (aPst - aPd) / penyebut;
    double tempPet = aPst + bPst * tempQet;

    if (tempQe < 0 || tempPe < 0 || tempQet < 0 || tempPet < 0) {
      setState(() {
        hasil = 'Nilai Qe, Pe, Qet, dan Pet tidak boleh negatif.\nPeriksa kembali input.';
        Qe = null;
        Pe = null;
        Qet = null;
        Pet = null;
        qetValue = '';
        petValue = '';
      });
      return;
    }

    double tk = tempPet - tempPe;
    double tp = t - tk;
    double T = t * tempQet;

    setState(() {
      Qe = tempQe;
      Pe = tempPe;
      Qet = tempQet;
      Pet = tempPet;

      hasil =
          'FUNGSI SEBELUM PAJAK:\n\n'
          'Pd(Q) = ${formatAngka(aPd)} + ${formatAngka(bPd)}Q\n'
          'Ps(Q) = ${formatAngka(aPs)} + ${formatAngka(bPs)}Q\n\n'
          'Cari Qe dari Pd = Ps:\n'
          '${formatAngka(aPd)} + ${formatAngka(bPd)}Q = ${formatAngka(aPs)} + ${formatAngka(bPs)}Q\n'
          'Qe = (${formatAngka(aPs)} - ${formatAngka(aPd)}) / (${formatAngka(bPd)} - ${formatAngka(bPs)}) = ${formatAngka(Qe!)}\n'
          'Pe = ${formatAngka(aPd)} + ${formatAngka(bPd)} x ${formatAngka(Qe!)} = ${formatAngka(Pe!)}\n\n'
          '-------------------------\n\n'
          'FUNGSI SETELAH PAJAK:\n\n'
          'Pst(Q) = (${formatAngka(aPs)} + ${formatAngka(t)}) + ${formatAngka(bPs)}Q = ${formatAngka(aPst)} + ${formatAngka(bPst)}Q\n'
          'Pd(Q) = ${formatAngka(aPd)} + ${formatAngka(bPd)}Q\n\n'
          'Cari Qet dari Pd = Pst:\n'
          '${formatAngka(aPd)} + ${formatAngka(bPd)}Q = ${formatAngka(aPst)} + ${formatAngka(bPst)}Q\n'
          'Qet = (${formatAngka(aPst)} - ${formatAngka(aPd)}) / (${formatAngka(bPd)} - ${formatAngka(bPst)}) = ${formatAngka(Qet!)}\n'
          'Pet = ${formatAngka(aPst)} + ${formatAngka(bPst)} x ${formatAngka(Qet!)} = ${formatAngka(Pet!)}\n'
          '-------------------------\n\n'
          'Keseimbangan Sebelum Pajak:\nQe = ${formatAngka(Qe!)}\nPe = ${formatAngka(Pe!)}\n'
          '(Qe,Pe) = (${formatAngka(Qe!)},${formatAngka(Pe!)})\n\n'
          'Keseimbangan Setelah Pajak:\nQet = ${formatAngka(Qet!)}\nPet = ${formatAngka(Pet!)}\n'
          '(Qet,Pet) = (${formatAngka(Qet!)},${formatAngka(Pet!)})\n\n'
          '-------------------------\n\n'
          'Pajak yang Ditanggung Konsumen (tk):\n'
          'tk = Pet - Pe = ${formatAngka(Pet!)} - ${formatAngka(Pe!)} = ${formatAngka(tk)}\n\n'
          'Pajak yang Ditanggung Produsen (tp):\n'
          'tp = t - tk = ${formatAngka(t)} - ${formatAngka(tk)} = ${formatAngka(tp)}\n\n'
          'Pajak yang Diterima Pemerintah (T):\n'
          'T = t x Qet = ${formatAngka(t)} x ${formatAngka(Qet!)} = ${formatAngka(T)}';

      qetValue = formatAngka(Qet!);
      petValue = formatAngka(Pet!);
    });
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
                fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
          ),
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
    tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 255, 175),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'PAJAK SPESIFIK',
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
                  Text('PAJAK SPESIFIK', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.black)),
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
            _inputField('Pajak Spesifik (t)', tController),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildButton('HITUNG', _hitung, const Color.fromARGB(255, 70, 253, 76))),
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
            if (Qe != null && Pe != null && Qet != null && Pet != null)
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
                              sideTitles: SideTitles(showTitles: true, interval: 5, getTitlesWidget: (value, _) => Text(value.toInt().toString())),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true, interval: 5, getTitlesWidget: (value, _) => Text(value.toInt().toString())),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          lineBarsData: [
                            LineChartBarData(spots: [FlSpot(Qe!, Pe!)], isCurved: false, color: Colors.blue, barWidth: 0, dotData: FlDotData(show: true)),
                            LineChartBarData(spots: [FlSpot(Qet!, Pet!)], isCurved: false, color: Colors.red, barWidth: 0, dotData: FlDotData(show: true)),
                          ],
                          minX: 0,
                          maxX: max(Qe!, Qet!) + 10,
                          minY: 0,
                          maxY: max(Pe!, Pet!) + 10,
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                          lineTouchData: LineTouchData(enabled: true),
                          extraLinesData: ExtraLinesData(
                            extraLinesOnTop: true,
                            horizontalLines: [
                              HorizontalLine(y: Pe!, color: Colors.blue, strokeWidth: 1, dashArray: [4, 4]),
                              HorizontalLine(y: Pet!, color: Colors.red, strokeWidth: 1, dashArray: [4, 4]),
                            ],
                            verticalLines: [
                              VerticalLine(x: Qe!, color: Colors.blue, strokeWidth: 1, dashArray: [4, 4]),
                              VerticalLine(x: Qet!, color: Colors.red, strokeWidth: 1, dashArray: [4, 4]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, size: 12, color: Colors.blue),
                        SizedBox(width: 4),
                        Text('Sebelum Pajak', style: TextStyle(fontSize: 13)),
                        SizedBox(width: 16),
                        Icon(Icons.circle, size: 12, color: Colors.red),
                        SizedBox(width: 4),
                        Text('Setelah Pajak', style: TextStyle(fontSize: 13)),
                      ],
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
