import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Target { none, c, s }

class KalkulatorKonsumsiOtonomPage extends StatefulWidget {
  const KalkulatorKonsumsiOtonomPage({super.key});

  @override
  State<KalkulatorKonsumsiOtonomPage> createState() =>
      _KalkulatorKonsumsiOtonomPageState();
}

class _KalkulatorKonsumsiOtonomPageState extends State<KalkulatorKonsumsiOtonomPage> {
  final _coCtrl = TextEditingController();
  final _mpcCtrl = TextEditingController();
  final _yCtrl = TextEditingController();
  final _cCtrl = TextEditingController();
  final _sCtrl = TextEditingController();

  Target _target = Target.none;
  String _message = '';
  
  String formatNumber(double value) {
  if (value == value.toInt()) {
    return value.toInt().toString(); // Jika integer
  } else {
    return value.toString(); // Tampilkan sebagaimana adanya (double)
  }
}


  void _reset() {
    _coCtrl.clear();
    _mpcCtrl.clear();
    _yCtrl.clear();
    _cCtrl.clear();
    _sCtrl.clear();
    setState(() {
      _target = Target.none;
      _message = '';
    });
  }

  bool _hide(Target id) {
    if (_target == Target.none) return false;
    return id == Target.c || id == Target.s;
  }

  bool _isInput(Target id) {
    if (_target == Target.none) return false;
    return id == Target.none;
  }

  Widget _field(String label, TextEditingController ctrl, Target id) {
    if (_hide(id)) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        enabled: _isInput(id),
        readOnly: !_isInput(id),
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

Widget _targetButton(String text, Target t) => Material(
  color: Colors.transparent,
  child: InkWell(
    onTap: () {
      setState(() {
        _target = t;
        _message = '';
        _cCtrl.clear();
        _sCtrl.clear();
      });
    },
    borderRadius: BorderRadius.circular(8), // Agar efek splash tidak keluar dari border
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: _target == t ? const Color.fromARGB(255, 27, 255, 19) : Colors.grey.shade700,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  ),
);


  void _hitung() {
    final co = double.tryParse(_coCtrl.text);
    final mpc = double.tryParse(_mpcCtrl.text);
    final y = double.tryParse(_yCtrl.text);

    if (co == null || mpc == null || y == null) {
      setState(() => _message = 'Co, MPC, dan Y wajib diisi!');
     return;
    }
    if (mpc <= 0.5 || mpc >= 1) {
      setState(() => _message = 'MPC harus lebih dari 0.5 dan kurang dari 1!');
      return;
    }

  switch (_target) {
    case Target.c:
      final c = co + mpc * y;
      _cCtrl.text = formatNumber(c);
      setState(() => _message = 'C = ${formatNumber(c)}');
      break;

    case Target.s:
      final s = -co + (1 - mpc) * y;
      _sCtrl.text = formatNumber(s);
      setState(() => _message = 'S = ${formatNumber(s)}');
      break;

    case Target.none:
      setState(() => _message = 'Pilih tombol HITUNG C atau HITUNG S.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'KONSUMSI OTONOM',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 153, 245, 173),
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
                    'KONSUMSI TABUNGAN',
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
              const Text(
                'Pilih salah satu yang ingin dihitung :)',
                style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _targetButton('Kons.(C)', Target.c),
                  _targetButton('Tab.(S)', Target.s),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _field('Co (Konsumsi Otonom)', _coCtrl, Target.none),
                        _field('MPC (Marginal Propensity to Consume)', _mpcCtrl, Target.none),
                        _field('Y  (Pendapatan Nasional)', _yCtrl, Target.none),
                        _field('S  (Saving/Tabungan)', _sCtrl, Target.s),
                        _field('C  (Consumption/Konsumsi)', _cCtrl, Target.c),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitung,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 16, 255, 48),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'HITUNG',
                            style: TextStyle(
                                fontFamily: 'PressStart2P',
                                fontSize: 12,
                                color: Colors.white),
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
                          color: const Color.fromARGB(255, 255, 29, 29),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'RESET',
                            style: TextStyle(
                                fontFamily: 'PressStart2P',
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.white),
                  child: ListView(
                    children: [
                      const Text(
                        'Hasil :',
                        style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _message,
                        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _coCtrl.dispose();
    _mpcCtrl.dispose();
    _yCtrl.dispose();
    _cCtrl.dispose();
    _sCtrl.dispose();
    super.dispose();
  }
}
