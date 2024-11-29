import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: FakirlikWidget(),
    ),
  );
}

class FakirlikWidget extends StatefulWidget {
  const FakirlikWidget({super.key});

  @override
  _FakirlikWidgetState createState() => _FakirlikWidgetState();
}

class _FakirlikWidgetState extends State<FakirlikWidget> {
  double _topPosition = -100; // Başlangıçta pop-up dışarıda
  bool _isPopupVisible = false; // Pop-up görünürlüğü
  String popupText = ''; // Pop-up metni

  // Pop-up'ı gösteren fonksiyon
  void _showPopup(String text) {
    setState(() {
      _isPopupVisible = true;
      popupText = text;
      _topPosition = MediaQuery.of(context).size.height /
          3; // Pop-up ekranın ortasına gelir
    });
  }

  // Pop-up'ı gizleyen fonksiyon
  void _hidePopup() {
    setState(() {
      _topPosition = -100; // Pop-up yukarıya doğru kayar
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isPopupVisible = false; // Pop-up'ı gizle
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900], // Koyu mavi arka plan
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80.0), // AppBar'ın yüksekliğini ayarlıyoruz
        child: AppBar(
          backgroundColor: Colors.lightBlue, // Gökyüzü mavisi renk
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0), // Sol alt köşe yuvarlama
              bottomRight: Radius.circular(30.0), // Sağ alt köşe yuvarlama
            ),
          ),
          elevation: 10, // Hafif gölge ekliyoruz
          title: const Center(
            child: Text(
              "I am Poor",
              style: TextStyle(
                color: Colors.orange, // Beyaz yazı
                fontSize: 30, // Daha büyük yazı boyutu
                fontWeight: FontWeight.bold, // Kalın yazı
                fontFamily:
                    'RobotoSlab', // Şatafatlı font (RobotoSlab gibi bir font seçilebilir)
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // Gölge bulanıklığı
                    color: Colors.black, // Gölge rengi ve şeffaflık
                    offset: Offset(2.0, 2.0), // Gölgenin konumu
                  ),
                  Shadow(
                    blurRadius: 15.0,
                    color: Colors.yellow, // Altın renkli ikinci gölge
                    offset: Offset(-2.0, -2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Body'nin en üst kısmına sabitlenen tıklanabilir kutucuklar
          Positioned(
            top: 10, // Üstten 10px boşluk bırakıyoruz
            left: 10, // Sol kenardan 10px boşluk bırakıyoruz
            right: 10, // Sağ kenardan 10px boşluk bırakıyoruz
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showPopup('Uyku düzenini toparla');
                  },
                  child: const Text('Sorunu Çöz'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showPopup('Günde 40-60 dakikanı spora ayır');
                  },
                  child: const Text('Harekete Geç'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showPopup(
                        'Hayatını düzene koy, spor ve uyku düzenini de bu işe kat');
                  },
                  child: const Text('Zengin Ol'),
                ),
              ],
            ),
          ),

          // Destek İste butonu ve diğer içerikler
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/fakirlik.jpg',
                    width: 150, // Fotoğrafın genişliği
                    height: 150, // Fotoğrafın yüksekliği
                    fit: BoxFit.cover, // Görüntüyü düzgün yerleştirir
                  ),
                ),
                const SizedBox(
                    height:
                        40), // Fotoğraf ile buton arasında daha fazla boşluk

                ElevatedButton(
                  onPressed: () {
                    _showPopup('Destek iste butonuna tıklandı');
                  }, // Parametresiz çağrı
                  child: const Text("Destek İste"),
                ),
              ],
            ),
          ),

          // Yumuşak geçiş efekti için AnimatedPositioned kullanıyoruz
          AnimatedPositioned(
            top: _topPosition, // Pop-up'ın üstten olan pozisyonu
            left: 50,
            right: 50,
            duration: const Duration(milliseconds: 700), // Geçiş süresi
            curve: Curves.easeInOut, // Geçiş animasyonunun pürüzsüz olması için
            child: AnimatedOpacity(
              opacity:
                  _isPopupVisible ? 0.9 : 0.0, // Pop-up şeffaflığını artırdık
              duration:
                  const Duration(seconds: 1), // Yavaşça görünmesini sağlıyoruz
              child: _isPopupVisible
                  ? Container(
                      width: 200, // Genişlik boyutunu küçültüyoruz
                      height: 200, // Yüksekliği küçültüyoruz
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Pop-up arka planı
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              popupText,
                              style: const TextStyle(
                                fontSize: 16, // Yazı boyutunu küçültüyoruz
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed:
                                _hidePopup, // "Tamam" butonuna tıklayınca kaybolsun
                            child: const Text('Tamam'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
