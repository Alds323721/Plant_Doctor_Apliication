# Alur Aplikasi (App Flow) - Plant Doctor

## 1. Alur Utama (Happy Flow)
[cite_start]Fokus pada kelancaran presentasi dan transisi antar halaman (routing) yang mulus[cite: 27, 28].
* **Splash Screen:** Menampilkan logo Plant Doctor singkat.
* [cite_start]**Dashboard / Halaman "Koleksi Tanamanku" [cite: 17][cite_start]:** Menampilkan daftar tanaman yang pernah dipindai dan artikel tips perawatan tanaman[cite: 17].
* [cite_start]**Tombol Kamera Utama (Floating Action Button):** Pengguna menekan tombol untuk masuk ke mode diagnosis instan[cite: 17].
* [cite_start]**Halaman Kamera:** Pengguna mengarahkan kamera dan memotret daun tanaman yang layu atau sakit.
* [cite_start]**Loading State:** Menampilkan *skeleton loading indicator* saat aplikasi mengirim gambar ke API pendeteksi penyakit[cite: 16, 28].
* [cite_start]**Halaman Hasil Diagnosis:** Menampilkan gambar yang dipindai, nama penyakit, persentase akurasi, dan langkah-langkah cara penanganannya dari database online.

## 2. Alur Navigasi (Routing)
* [cite_start]Menggunakan *routing* standar Flutter dengan transisi *fade* atau *slide* agar terasa mulus[cite: 28].
* Terdapat navigasi kembali (*back button*) di setiap halaman detail untuk mencegah pengguna terjebak di satu halaman.