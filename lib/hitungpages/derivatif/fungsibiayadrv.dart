import 'package:flutter/material.dart';

class FungsiBiayaDerivatifPage extends StatefulWidget {
  const FungsiBiayaDerivatifPage({super.key});

  @override
  State<FungsiBiayaDerivatifPage> createState() => _FungsiBiayaDerivatifPageState();
}

class _FungsiBiayaDerivatifPageState extends State<FungsiBiayaDerivatifPage> {
  final qController = TextEditingController(); // Quantity (Q)
  final cController = TextEditingController(); // Konstanta
  final q1Controller = TextEditingController(); // Koef Q^1
  final q2Controller = TextEditingController(); // Koef Q^2
  final q3Controller = TextEditingController(); // Koef Q^3

  String hasil = '';
  int pangkatTerbesar = 1;

  double _parse(TextEditingController ctrl) =>
      double.tryParse(ctrl.text.trim()) ?? 0;

  String formatKoefDariInput(TextEditingController ctrl) {
    final text = ctrl.text.trim();
    if (text.contains('.') && double.tryParse(text) != null) {
      final val = double.parse(text);
      return val.toString();
    }
    final val = double.tryParse(text);
    if (val != null) {
      return val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);
    }
    return '0';
  }

  String formatHasil(num val) =>
      val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);

  void _hitung() {
    final q = double.tryParse(qController.text);
    if (q == null || q == 0) {
      setState(() => hasil = 'Nilai Q tidak valid atau nol');
      return;
    }

    final a = pangkatTerbesar >= 3 ? _parse(q3Controller) : 0;
    final b = pangkatTerbesar >= 2 ? _parse(q2Controller) : 0;
    final c = _parse(q1Controller);
    final d = _parse(cController);

    final tc = a * q * q * q + b * q * q + c * q + d;
    final mc = 3 * a * q * q + 2 * b * q + c;
    final ac = tc / q;

    List<String> termsTC = [];
    if (a != 0) termsTC.add('${formatKoefDariInput(q3Controller)}Q³');
    if (b != 0) termsTC.add('${formatKoefDariInput(q2Controller)}Q²');
    if (c != 0) termsTC.add('${formatKoefDariInput(q1Controller)}Q');
    if (d != 0) termsTC.add('${formatKoefDariInput(cController)}');
    final bentukTC = termsTC.join(' + ');

    List<String> termsMC = [];
    if (a != 0) termsMC.add('${formatHasil(3 * a)}Q²');
    if (b != 0) termsMC.add('${formatHasil(2 * b)}Q');
    if (c != 0) termsMC.add('${formatHasil(c)}');
    final bentukMC = termsMC.join(' + ');

    setState(() {
      hasil = 
          'TC = $bentukTC\n\n'
          'TC = ${formatHasil(tc)}\n\n'
          '---------------------------\n\n'
          'MC = $bentukMC\n\n'
          'MC = ${formatHasil(mc)}\n\n'
          '---------------------------\n\n'
          'AC = ${formatHasil(ac)}';
    });
  }

  void _reset() {
    qController.clear();
    cController.clear();
    q1Controller.clear();
    q2Controller.clear();
    q3Controller.clear();
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
    qController.dispose();
    cController.dispose();
    q1Controller.dispose();
    q2Controller.dispose();
    q3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 252, 156),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'FUNGSI BIAYA',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
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
                    'FUNGSI BIAYA',
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
            if (pangkatTerbesar >= 3) _field('Koefisien Q³', q3Controller),
            if (pangkatTerbesar >= 2) _field('Koefisien Q²', q2Controller),
            _field('Koefisien Q¹', q1Controller),
            _field('Konstanta', cController),
            _field('Jumlah Output (Q)', qController),
            const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitung,
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
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2), color: Colors.white),
              child: Text(
                hasil.isNotEmpty ? hasil : 'Hasil :',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
