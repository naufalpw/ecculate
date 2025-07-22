import 'package:flutter/material.dart';

class FungsiTabunganPage extends StatefulWidget {
  @override
  _FungsiTabunganPageState createState() => _FungsiTabunganPageState();
}

class _FungsiTabunganPageState extends State<FungsiTabunganPage> {
  final mpsController = TextEditingController();
  final mpcController = TextEditingController();
  final kController = TextEditingController();
  final yController = TextEditingController();

  bool mpsDisabled = false;
  bool mpcDisabled = false;
  bool validasiSukses = false;
  String hasil = '';

  void _validasi() {
    double mps = double.tryParse(mpsController.text) ?? -1;
    double mpc = double.tryParse(mpcController.text) ?? -1;

    if (mps > 0 && mps < 0.5 && mpcController.text.isEmpty) {
      mpc = 1 - mps;
      mpcController.text = formatAngka(mpc);
      mpcDisabled = true;
    } else if (mpc > 0.5 && mpc < 1 && mpsController.text.isEmpty) {
      mps = 1 - mpc;
      mpsController.text = formatAngka(mps);
      mpsDisabled = true;
    }

    if (mpc <= 0.5 || mpc >= 1 || mps <= 0 || mps >= 0.5) {
      setState(() {
        hasil = 'MPC harus > 0.5 dan < 1\nMPS harus > 0 dan < 0.5';
        validasiSukses = false;
      });
      return;
    }

    if ((mpc + mps - 1).abs() > 0.0001) {
      setState(() {
        hasil = 'MPC + MPS harus = 1';
        validasiSukses = false;
      });
      return;
    }

    setState(() {
      hasil = 'Validasi berhasil. Silakan isi nilai k dan Y.';
      validasiSukses = true;
    });
  }

  void _hitung() {
    if (!validasiSukses) {
      setState(() {
        hasil = 'Silakan validasi MPS/MPC terlebih dahulu';
      });
      return;
    }

    double mps = double.tryParse(mpsController.text) ?? 0;
    double k = double.tryParse(kController.text) ?? 0;
    double y = double.tryParse(yController.text) ?? 0;

    if (y <= 0) {
      setState(() {
        hasil = 'Pendapatan (Y) harus lebih dari 0';
      });
      return;
    }

    double integral = mps * y;
    double s = integral - k;

    setState(() {
      hasil =
          'S(Y) = ∫MPS dY\n'
          '     = ${formatAngka(mps)}Y - k\n'
          '     = ${formatAngka(mps)}(${formatAngka(y)}) - ${formatAngka(k)}\n'
          '     = ${formatAngka(integral)} - ${formatAngka(k)}\n'
          '     = ${formatAngka(s)}\n'
          'S(Y) = ${formatAngka(s)}';
    });
  }

  void _reset() {
    mpsController.clear();
    mpcController.clear();
    kController.clear();
    yController.clear();
    setState(() {
      hasil = '';
      mpsDisabled = false;
      mpcDisabled = false;
      validasiSukses = false;
    });
  }

  void _handleMPSChange(String value) {
    setState(() {
      hasil = '';
      validasiSukses = false;
    });
  }

  void _handleMPCChange(String value) {
    setState(() {
      hasil = '';
      validasiSukses = false;
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
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 10,
            color: Colors.black87,
          ),
        ),
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
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _adaptiveButton(String label, Color color, VoidCallback onTap) {
    return IntrinsicWidth(
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
              boxShadow: const [
                BoxShadow(color: Colors.black54, offset: Offset(3, 3)),
              ],
            ),
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
      ),
    );
  }

  Widget _button(String label, Color color, VoidCallback onTap) {
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
              boxShadow: const [
                BoxShadow(color: Colors.black54, offset: Offset(3, 3)),
              ],
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 243, 182),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'FUNGSI TABUNGAN',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
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
                    'FUNGSI TABUNGAN',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _inputField('MPS (Marginal Propensity to Save)', mpsController,
                disabled: mpsDisabled, onChanged: _handleMPSChange),
            _inputField('MPC (Marginal Propensity to Consume)', mpcController,
                disabled: mpcDisabled, onChanged: _handleMPCChange),
            const SizedBox(height: 10),
            Center(child: _adaptiveButton('CEK MPC/MPS', Colors.orange, _validasi)),
            const SizedBox(height: 20),
            _inputField('Konstanta hasil integral (k)', kController,
                disabled: !validasiSukses),
            _inputField('Pendapatan Nasional (Y)', yController,
                disabled: !validasiSukses),
            const SizedBox(height: 20),
            Row(
              children: [
                _button('HITUNG', const Color.fromARGB(255, 49, 255, 56), _hitung),
                const SizedBox(width: 10),
                _button('RESET', const Color.fromARGB(255, 255, 53, 38), _reset),
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
                hasil.isNotEmpty ? hasil : 'Hasil :',
                style: const TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mpsController.dispose();
    mpcController.dispose();
    kController.dispose();
    yController.dispose();
    super.dispose();
  }
}
