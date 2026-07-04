# Daftar Fitur - Plant Doctor

## 1. Fitur Sensor & Kamera
* [cite_start]Akses kamera bawaan perangkat untuk memotret objek tanaman.
* Fitur unggah gambar dari galeri perangkat sebagai alternatif jika tidak memotret langsung.

## 2. Fitur Network & API
* [cite_start]Integrasi HTTP Request ke API pihak ketiga seperti PlantId API atau PlantNet API.
* [cite_start]Parsing data respons JSON dari API untuk diekstrak menjadi data diagnosis dan cara penanganan[cite: 16, 26].
* Penanganan *error* jaringan (misalnya peringatan saat tidak ada koneksi internet).

## 3. Fitur Routing & UI
* [cite_start]Halaman "Koleksi Tanamanku" untuk menyimpan riwayat diagnosis[cite: 17].
* [cite_start]Halaman diagnosis instan dengan tampilan *overlay* pada kamera[cite: 17].
* [cite_start]Halaman artikel yang berisi daftar tips perawatan tanaman harian[cite: 17].

## 4. Keandalan Performa
* [cite_start]*Data Fetching Handling:* Penggunaan indikator *loading* saat aplikasi mengambil data dari API agar aplikasi tidak terlihat *freeze*[cite: 28].