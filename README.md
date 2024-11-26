# Mineat Mobile

# Discover Minang cuisine within minutes with Mineat!

## Anggota Kelompok C04
- [Khansa Khairunisa](https://github.com/khansakhai) (2306152462)
- [Abdul Zacky](https://github.com/abdul-zacky) (2306214510)
- [Ragnall Muhammad Al Fath](https://github.com/Ragnall16) (2306210550)
- [Muhammad Fadhlan Arradhi](https://github.com/Arradhi) (2306240061)
- [Cahya Bagus Gautama Gozales](https://github.com/cahyabgg) (2306275380)

## Asal-Usul Mineat: Jelajahi Rasa Nusantara dari Tanah Minang
Nama Mineat berasal dari kata "Minang" yang merujuk pada suku Minangkabau di Sumatera Barat, dan "eat" yang berarti makan. Mineat adalah jendela digital yang membuka panorama lezat kuliner Padang, mengajak pengguna menjelajahi kekayaan rasa dan cerita di balik setiap hidangan khas Minangkabau. Mineat bagaikan sebuah perjalanan kuliner yang membawa pengguna melintasi beragam cita rasa Padang, dari yang pedas hingga yang kaya akan kelezatan. Setiap langkah dalam 'petualangan rasa' ini membuka wawasan tentang kearifan lokal dan filosofi hidup masyarakat Minang, yang tersaji indah dalam setiap hidangan.

Mineat merupakan aplikasi direktori kuliner digital yang berfokus pada makanan khas Padang. Aplikasi ini menyediakan informasi tentang berbagai hidangan tradisional Minangkabau yang dapat ditemukan di kota Padang. Dengan berbagai fitur yang menarik, Mineat memungkinkan pengguna untuk menjelajahi, menemukan, dan mempelajari tentang beragam masakan Padang.

Aplikasi Mineat dilengkapi dengan berbagai fitur yang mendukung pengalaman pengguna dalam menjelajahi hidangan khas Minangkabau, yaitu:

- Search bar untuk mencari makanan spesifik
- Filter agar pengguna dapat melihat makan sesuai dengan bahan makanan yang mereka pilih
- QnA/Forum agar pengguna dapat lebih lanjut mendiskusikan makanan, serta budaya Padang
- Memberikan nilai/review untuk setiap makanan dan restoran
- Lokasi untuk menampilkan lokasi favorit pengguna di kota padang
- Fitur yang saling menghubungkan makanan, restoran, serta lokasi

Mineat bertujuan untuk melestarikan warisan kuliner Minangkabau dengan cara yang modern dan interaktif, sekaligus mendukung industri kuliner lokal di Padang. Aplikasi ini tidak hanya bermanfaat bagi wisatawan yang ingin menjelajahi kekayaan kuliner Padang, tetapi juga bagi penduduk lokal yang ingin memperdalam pengetahuan mereka tentang masakan tradisional mereka sendiri. 

## Daftar Modul

- ### Makanan

**Dikerjakan oleh Abdul Zacky**

Pada fitur ini, pengguna dapat mencari makanan yang mereka inginkan.

- ### Bahan Makanan

**Dikerjakan oleh Cahya Bagus Gautama Gozales**

Pada fitur ini, pengguna dapat mem-filter jenis makanan yang ingin mereka cari berdasarkan bahan yang dipilih

- ### Restoran

**Dikerjakan oleh Ragnall Muhammad Al Fath**

Pada fitur ini, pengguna dapat menemukan makanan berdasarkan restoran yang mereka pilih.

- ### Review

**Dikerjakan oleh Muhammad Fadhlan Arradhi**

Pada fitur ini, pengguna dapat memberikan review berupa nilai dan komentar untuk setiap makanan dan restoran.

- ### QnA/Forum

**Dikerjakan oleh Khansa Khairunisa**

Pada fitur ini, pengguna dapat melakukan tanya-jawab dengan pengguna lainnya seputar hidangan khas Padang, ataupun budayanya. 

- ### Lokasi

Pada fitur ini, pengguna dapat melihat lokasi favorit pengguna di Kota Padang

Mineat dirancang untuk memiliki fitur yang memungkinkan setiap pengguna untuk menambahkan, menghapus, dan mengedit informasi tentang berbagai makanan dan restoran. Harapannya, aplikasi ini menjadi lebih inklusif, di mana siapa pun dapat berkontribusi untuk memperkaya konten dan menjadikan pengalaman menjelajahi kuliner lebih beragam dan informatif.
## Sumber Initial Dataset

Mineat menggunakan dataset publik dari [Wikipedia](https://en.wikipedia.org/), yaitu: [Padang cuisine](https://en.wikipedia.org/wiki/Padang_cuisine). Dataset ini dipilih karena mencakup informasi yang mendetail tentang berbagai hidangan tradisional Minangkabau, serta menyajikan konteks budaya yang kaya. 
  
## Role atau Peran Pengguna Beserta Deskripsinya

| Feature                         | Logged In User  | Non Logged In User |
|----------------------------------|:-----------------:|:--------------------:|
| Review food and restaurants      | ✅               | ❌                 |
| Initiating and responding a QnA  | ✅               | ❌                 |
| View food and restaurants        | ✅               | ✅                 |
| Filter food and restaurants      | ✅               | ✅                 |

## Alur Pengintegrasian dengan Aplikasi Web
Berikut adalah langkah-langkah yang dilakukan untuk mengintegrasikan aplikasi Django dengan Flutter. 
1. Menambahkan library `http` pada proyek Flutter untuk memungkinkan komunikasi antara aplikasi Flutter dan server Django melalui HTTP request.
2. Membuat model data di Flutter yang sesuai dengan struktur data JSON yang dikirim dari server Django. Kami memanfaatkan situs web [Quicktype](http://app.quicktype.io/) untuk mengubah JSON menjadi objek Dart. 
3. Mengirim HTTP request ke server Django menggunakan library `http`. Kami menggunakan endpoint yang sesuai dengan API yang telah dibuat pada server. 
4. Mengonversi data yang diterima dari server (dalam format JSON) menjadi objek Dart menggunakan model yang telah dibuat pada langkah kedua. 
5. Menampilkan data yang telah dikonversi di dalam aplikasi, menggunakan widget `FutureBuilder` agar data dapat dilihat langsung oleh pengguna secara dinamis. 