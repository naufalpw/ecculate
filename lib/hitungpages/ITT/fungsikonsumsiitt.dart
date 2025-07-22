import 'package:flutter/material.dart';

class FungsiKonsumsiPage extends StatefulWidget {
  @override
  _FungsiKonsumsiPageState createState() => _FungsiKonsumsiPageState();
}

class _FungsiKonsumsiPageState extends State<FungsiKonsumsiPage> {
  final mpcController = TextEditingController();
  final mpsController = TextEditingController();
  final kController = TextEditingController();
  final yController = TextEditingController();

  bool mpcDisabled = false;
  bool mpsDisabled = false;
  bool validasiBerhasil = false;

  String hasil = '';

  void _validasi() {
    double mpc = double.tryParse(mpcController.text) ?? -1;
    double mps = double.tryParse(mpsController.text) ?? -1;

    if (mpc > 0.5 && mpc < 1 && mpsController.text.isEmpty) {
      mps = 1 - mpc;
      mpsController.text = formatAngka(mps);
      mpsDisabled = true;
    } else if (mps > 0 && mps < 0.5 && mpcController.text.isEmpty) {
      mpc = 1 - mps;
      mpcController.text = formatAngka(mpc);
      mpcDisabled = true;
    }

    if (mpc <= 0.5 || mpc >= 1 || mps <= 0 || mps >= 0.5) {
      setState(() {
        hasil = 'MPC harus > 0.5 dan < 1\nMPS harus > 0 dan < 0.5';
        validasiBerhasil = false;
      });
      return;
    }

    if ((mpc + mps - 1).abs() > 0.0001) {
      setState(() {
        hasil = 'MPC + MPS harus = 1';
        validasiBerhasil = false;
      });
      return;
    }

    setState(() {
      hasil = 'Validasi berhasil. Silakan isi nilai k dan Y.';
      validasiBerhasil = true;
    });
  }

  void _hitung() {
    if (!validasiBerhasil) {
      setState(() {
        hasil = 'Silakan lakukan validasi terlebih dahulu.';
      });
      return;
    }

    double mpc = double.tryParse(mpcController.text) ?? 0;
    double k = double.tryParse(kController.text) ?? 0;
    double y = double.tryParse(yController.text) ?? 0;

    if (y <= 0) {
      setState(() {
        hasil = 'Pendapatan (Y) harus lebih dari 0';
      });
      return;
    }

    double integral = mpc * y;
    double c = integral + k;

    setState(() {
      hasil =
          'C(Y) = ∫MPC dY\n'
          '     = ${formatAngka(mpc)}Y + k\n'
          '     = ${formatAngka(mpc)}(${formatAngka(y)}) + ${formatAngka(k)}\n'
          '     = ${formatAngka(integral)} + ${formatAngka(k)}\n'
          '     = ${formatAngka(c)}\n'
          'C(Y) = ${formatAngka(c)}';
    });
  }

  void _reset() {
    mpcController.clear();
    mpsController.clear();
    kController.clear();
    yController.clear();
    setState(() {
      hasil = '';
      mpcDisabled = false;
      mpsDisabled = false;
      validasiBerhasil = false;
    });
  }

  void _handleMPCChange(String value) {
    setState(() {
      hasil = '';
      validasiBerhasil = false;
    });
  }

  void _handleMPSChange(String value) {
    setState(() {
      hasil = '';
      validasiBerhasil = false;
    });
  }

  String formatAngka(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+\$'), '');
  }

  Widget _inputField(String label, TextEditingController controller,
      {bool disabled = false, void Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: 'PressStart2P', fontSize: 10, color: Colors.black87)),
        const SizedBox(height: 5),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            enabled: !disabled,
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              hintText: 'Masukkan nilai',
            ),
            style: const TextStyle(
                fontFamily: 'PressStart2P', fontSize: 12, color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _centerAdaptiveButton(String label, Color color, VoidCallback onTap) {
    return Center(
      child: IntrinsicWidth(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(3, 3))],
              ),
              child: Text(
                label,
                style: const TextStyle(
                    fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wideButton(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(3, 3))],
            ),
            child: Center(
              child: Text(label,
                  style: const TextStyle(
                      fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 247, 174),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text('FUNGSI KONSUMSI',
            style: TextStyle(
                fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
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
                  Text('KALKULATOR',
                      style: TextStyle(
                          fontFamily: 'PressStart2P', fontSize: 24, color: Colors.deepOrange)),
                  SizedBox(height: 8),
                  Text('FUNGSI KONSUMSI',
                      style: TextStyle(
                          fontFamily: 'PressStart2P', fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _inputField('MPC (Marginal Propensity to Consume)', mpcController,
                disabled: mpcDisabled, onChanged: _handleMPCChange),
            _inputField('MPS (Marginal Propensity to Save)', mpsController,
                disabled: mpsDisabled, onChanged: _handleMPSChange),
            const SizedBox(height: 10),
            _centerAdaptiveButton('CEK MPC/MPS', Colors.orange, _validasi),
            const SizedBox(height: 20),
            _inputField('Konstanta hasil integral (k)', kController,
                disabled: !validasiBerhasil),
            _inputField('Pendapatan Nasional (Y)', yController,
                disabled: !validasiBerhasil),
            const SizedBox(height: 20),
            Row(
              children: [
                _wideButton('HITUNG', const Color.fromARGB(255, 46, 236, 52), _hitung),
                const SizedBox(width: 10),
                _wideButton('RESET', const Color.fromARGB(255, 250, 54, 40), _reset),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                hasil.isNotEmpty ? hasil : 'Hasil : ',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mpcController.dispose();
    mpsController.dispose();
    kController.dispose();
    yController.dispose();
    super.dispose();
  }
}
