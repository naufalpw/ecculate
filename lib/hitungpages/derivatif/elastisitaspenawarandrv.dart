import 'package:flutter/material.dart';

class ElastisitasPenawaranPage extends StatefulWidget {
  const ElastisitasPenawaranPage({super.key});

  @override
  State<ElastisitasPenawaranPage> createState() =>
      _ElastisitasPenawaranPageState();
}

class _ElastisitasPenawaranPageState extends State<ElastisitasPenawaranPage> {
  final pController = TextEditingController();
  final cController = TextEditingController();
  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();
  final p3Controller = TextEditingController();

  String hasil = '';
  int pangkatTerbesar = 1;

  double _parse(TextEditingController ctrl) =>
      double.tryParse(ctrl.text) ?? 0;

  String formatKoefDariInput(TextEditingController ctrl) {
    final text = ctrl.text.trim();
    if (text.contains('.') && double.tryParse(text) != null) {
      final val = double.parse(text);
      return val.toString(); // Tampilkan sesuai input user
    }
    final val = double.tryParse(text);
    if (val != null) {
      return val == val.toInt()
          ? val.toInt().toString()
          : val.toStringAsFixed(2);
    }
    return '0';
  }

  String formatHasil(double val) {
    return val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);
  }

  void _hitungElastisitas() {
    final nilaiP = double.tryParse(pController.text);
    if (nilaiP == null) {
      setState(() => hasil = 'Nilai P tidak valid');
      return;
    }

    final a = pangkatTerbesar >= 3 ? _parse(p3Controller) : 0;
    final b = pangkatTerbesar >= 2 ? _parse(p2Controller) : 0;
    final c = _parse(p1Controller);
    final d = _parse(cController);

    if (a == 0 && b == 0 && c == 0) {
      setState(() => hasil = 'Minimal satu koefisien harus diisi!');
      return;
    }

    final qs = a * nilaiP * nilaiP * nilaiP +
        b * nilaiP * nilaiP +
        c * nilaiP +
        d;

    final qsPrime = 3 * a * nilaiP * nilaiP + 2 * b * nilaiP + c;

    if (qs == 0) {
      setState(() => hasil = 'Nilai Qs tidak boleh nol');
      return;
    }

    final elastisitas = (qsPrime * nilaiP) / qs;

    final ket = elastisitas.abs() > 1
        ? 'Elastis'
        : elastisitas.abs() == 1
            ? 'Unitary Elastis'
            : elastisitas == 0
                ? 'Inelastis Sempurna'
                : elastisitas.abs().isInfinite
                    ? 'Elastis Tak Hingga'
                    : 'Inelastis';

    // Format bentuk Qs
    List<String> termsQs = [];
    if (a != 0) termsQs.add('${formatKoefDariInput(p3Controller)}P³');
    if (b != 0) termsQs.add('${formatKoefDariInput(p2Controller)}P²');
    if (c != 0) termsQs.add('${formatKoefDariInput(p1Controller)}P');
    if (d != 0) termsQs.add('${formatKoefDariInput(cController)}');
    final bentukQs = termsQs.join(' + ');

    String formatHasil(num val) {
      return val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);
    }

    // Format bentuk Qs'
    List<String> termsQsPrime = [];
    if (a != 0) termsQsPrime.add('${formatHasil(3 * a)}P²');
    if (b != 0) termsQsPrime.add('${formatHasil(2 * b)}P');
    if (c != 0) termsQsPrime.add('${formatHasil(c)}');
    final bentukQsPrime = termsQsPrime.join(' + ');

    

    setState(() {
      hasil = 'Qs = $bentukQs\n\n'
          'Qs = ${formatHasil(qs)}\n\n'
          '----------------------------\n\n'
          'Qs\' = $bentukQsPrime\n\n'
          'Qs\' = ${formatHasil(qsPrime)}\n\n'
          '----------------------------\n\n'
          'ŋs = ${elastisitas.abs().toStringAsFixed(3)} ($ket)\n';
    });
  }

  void _reset() {
    pController.clear();
    cController.clear();
    p1Controller.clear();
    p2Controller.clear();
    p3Controller.clear();
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
          labelStyle:
              const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
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
          DropdownMenuItem(
              value: 1,
              child: Text('Pangkat 1',
                  style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
          DropdownMenuItem(
              value: 2,
              child: Text('Pangkat 2',
                  style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
          DropdownMenuItem(
              value: 3,
              child: Text('Pangkat 3',
                  style: TextStyle(fontFamily: 'PressStart2P',fontSize: 12))),
        ],
        onChanged: (val) {
          if (val != null) setState(() => pangkatTerbesar = val);
        },
      ),
    );
  }

  @override
  void dispose() {
    pController.dispose();
    cController.dispose();
    p1Controller.dispose();
    p2Controller.dispose();
    p3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 255, 175),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'ELASTISITAS PENAWARAN',
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
                    'ELASTISITAS PENAWARAN',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
              const SizedBox(height: 16),
              _dropdown(),
              if (pangkatTerbesar >= 3) _field('Koefisien P³', p3Controller),
              if (pangkatTerbesar >= 2) _field('Koefisien P²', p2Controller),
              _field('Koefisien P¹', p1Controller),
              _field('Konstanta', cController),
              _field('Nilai P', pController),
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
