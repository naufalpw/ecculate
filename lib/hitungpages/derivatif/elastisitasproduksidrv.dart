import 'package:flutter/material.dart';

class ElastisitasProduksiPage extends StatefulWidget {
  const ElastisitasProduksiPage({super.key});

  @override
  State<ElastisitasProduksiPage> createState() => _ElastisitasProduksiPageState();
}

class _ElastisitasProduksiPageState extends State<ElastisitasProduksiPage> {
  final xController = TextEditingController();
  final cController = TextEditingController();
  final x1Controller = TextEditingController();
  final x2Controller = TextEditingController();
  final x3Controller = TextEditingController();

  String hasil = '';
  int pangkatTerbesar = 1;

  double _parse(TextEditingController ctrl) => double.tryParse(ctrl.text) ?? 0;

  String formatKoefDariInput(TextEditingController ctrl) {
    final text = ctrl.text.trim();
    if (text.contains('.') && double.tryParse(text) != null) {
      final val = double.parse(text);
      return val.toString();
    }
    final val = double.tryParse(text);
    if (val != null) {
      return val == val.toInt()
          ? val.toInt().toString()
          : val.toStringAsFixed(2);
    }
    return '0';
  }

  String formatHasil(num val) {
    return val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);
  }

  void _hitungElastisitas() {
    final nilaiX = double.tryParse(xController.text);
    if (nilaiX == null) {
      setState(() => hasil = 'Nilai X tidak valid');
      return;
    }

    final a = pangkatTerbesar >= 3 ? _parse(x3Controller) : 0;
    final b = pangkatTerbesar >= 2 ? _parse(x2Controller) : 0;
    final c = _parse(x1Controller);
    final d = _parse(cController);

    if (a == 0 && b == 0 && c == 0) {
      setState(() => hasil = 'Minimal satu koefisien harus diisi!');
      return;
    }

    final output = a * nilaiX * nilaiX * nilaiX +
        b * nilaiX * nilaiX +
        c * nilaiX +
        d;

    final outputPrime = 3 * a * nilaiX * nilaiX + 2 * b * nilaiX + c;

    if (output == 0) {
      setState(() => hasil = 'Nilai P tidak boleh nol');
      return;
    }

    final elastisitas = (outputPrime * nilaiX) / output;

    final ket = elastisitas.abs() > 1
        ? 'Elastis'
        : elastisitas.abs() == 1
            ? 'Unitary Elastis'
            : elastisitas == 0
                ? 'Inelastis Sempurna'
                : elastisitas.abs().isInfinite
                    ? 'Elastis Tak Hingga'
                    : 'Inelastis';

    // Format bentuk P (output)
    List<String> termsOutput = [];
    if (a != 0) termsOutput.add('${formatKoefDariInput(x3Controller)}X³');
    if (b != 0) termsOutput.add('${formatKoefDariInput(x2Controller)}X²');
    if (c != 0) termsOutput.add('${formatKoefDariInput(x1Controller)}X');
    if (d != 0) termsOutput.add('${formatKoefDariInput(cController)}');
    final bentukOutput = termsOutput.join(' + ');

    // Format bentuk P' (turunan output)
    List<String> termsOutputPrime = [];
    if (a != 0) termsOutputPrime.add('${formatHasil(3 * a)}X²');
    if (b != 0) termsOutputPrime.add('${formatHasil(2 * b)}X');
    if (c != 0) termsOutputPrime.add('${formatHasil(c)}');
    final bentukOutputPrime = termsOutputPrime.join(' + ');

    setState(() {
      hasil = 'P = $bentukOutput\n'
          'P = ${formatHasil(output)}\n\n'
          '----------------------------\n\n'
          'P\' = $bentukOutputPrime\n'
          'P\' = ${formatHasil(outputPrime)}\n\n'
          '----------------------------\n\n'
          'ŋp = ${elastisitas.abs().toStringAsFixed(3)} ($ket)\n';
    });
  }

  void _reset() {
    xController.clear();
    cController.clear();
    x1Controller.clear();
    x2Controller.clear();
    x3Controller.clear();
    hasil = '';
    pangkatTerbesar = 1;
    setState(() {});
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<int>(
        value: pangkatTerbesar,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Pangkat Tertinggi',
          filled: true,
          fillColor: Colors.white
        ),
        items: const [
          DropdownMenuItem(value: 1, child: Text('Pangkat 1', style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
          DropdownMenuItem(value: 2, child: Text('Pangkat 2', style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
          DropdownMenuItem(value: 3, child: Text('Pangkat 3', style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
        ],
        onChanged: (val) {
          if (val != null) setState(() => pangkatTerbesar = val);
        },
      ),
    );
  }


  @override
  void dispose() {
    xController.dispose();
    cController.dispose();
    x1Controller.dispose();
    x2Controller.dispose();
    x3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 255, 163),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'ELASTISITAS PRODUKSI',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
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
                  Text(
                    'KALKULATOR',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 24,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ELAS. PRODUKSI',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _dropdown(),
              if (pangkatTerbesar >= 3) _field('Koefisien X³', x3Controller),
              if (pangkatTerbesar >= 2) _field('Koefisien X²', x2Controller),
              _field('Koefisien X¹', x1Controller),
              _field('Konstanta', cController),
              _field('Jumlah Input (X)', xController),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitungElastisitas,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 243, 50),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black54, offset: Offset(4, 4))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'HITUNG',
                            style: TextStyle(
                              fontFamily: 'PressStart2P',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 43, 29),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black54, offset: Offset(4, 4))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'RESET',
                            style: TextStyle(
                              fontFamily: 'PressStart2P',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                ),
              child: Text(
                hasil.isNotEmpty ? hasil : 'Hasil :',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
