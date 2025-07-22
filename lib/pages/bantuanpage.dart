import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class BantuanPage extends StatefulWidget {
  const BantuanPage({Key? key}) : super(key: key);

  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isLoading = true;

  final String emailTujuan = 'naufalpnpw@gmail.com';

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.asset('assets/videos/Tutorial_EC-Culate.mp4');
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        showControlsOnInitialize: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color.fromARGB(255, 0, 241, 20),
          handleColor: const Color.fromARGB(255, 9, 250, 61),
          bufferedColor: Colors.grey,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading video: $e");
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'PUSAT BANTUAN',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Color.fromARGB(255, 185, 245, 161),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Video Tutorial Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      'TUTORIAL VIDEO',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 16),
                    if (_isLoading)
                      Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                          ),
                        ),
                      )
                    else
                      AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // FAQ Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PERTANYAAN UMUM:',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFAQItem(
                      question: 'Bagaimana cara menggunakan kalkulator?',
                      answer: 'Pilih menu kalkulator yang diinginkan, masukkan variabel yang dibutuhkan, kemudian tekan tombol hitung.',
                    ),
                    _buildFAQItem(
                      question: 'Apa fungsi dari fitur ini?',
                      answer: 'Aplikasi ini membantu perhitungan berbagai fungsi ekonomi seperti biaya, pendapatan, dan lainnya.',
                    ),
                    _buildFAQItem(
                      question: 'Bagaimana membaca hasil perhitungan?',
                      answer: 'Hasil akan ditampilkan di bagian bawah setelah menekan tombol hitung.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Contact Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    Text(
                      'HUBUNGI KAMI:',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildContactInfo(Icons.email, emailTujuan),
                    SizedBox(height: 10),
                    Material(
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 10,
            color: const Color.fromARGB(255, 241, 18, 18),
          ),
        ),
        SizedBox(height: 5),
        Text(
          answer,
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 10,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildContactInfo(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
