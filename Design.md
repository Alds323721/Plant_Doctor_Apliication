# UI/UX & Design System - Plant Doctor

## 1. Tema & Palet Warna
Desain harus terlihat profesional, ringan, dan bernuansa alam.
* **Warna Utama (Primary):** Hijau Zamrud atau Hijau Daun (misal: `#2E7D32` atau `#4CAF50`).
* **Warna Latar (Background):** Putih bersih (`#FFFFFF`) atau *Off-white* (`#F9F9F9`) untuk kesan minimalis dan *clean*.
* **Warna Aksen (Accent):** Kuning cerah atau *Orange* pastel untuk tombol aksi sekunder dan ikon peringatan penyakit.
* **Teks:** Abu-abu gelap (`#333333`) agar kontras tinggi dan mudah dibaca.

## 2. Gaya Visual (UI/UX Ringan)
* [cite_start]**Skeleton Loading:** Saat memuat data dari API (misal: menunggu hasil gambar atau memuat daftar tanaman), wajib menggunakan animasi *skeleton/shimmer* (kotak abu-abu berkedip halus)[cite: 28].
* **Card Design:** Penggunaan kartu (*cards*) dengan *shadow* yang sangat tipis untuk menampilkan daftar artikel atau riwayat tanaman agar terlihat rapi dan terstruktur.
* **Ikonografi:** Gunakan *icon set* yang membulat (*rounded*) agar ramah pengguna (misalnya Material Rounded Icons).

## 3. Detail Desain Halaman
* **Dashboard:** Bagian atas berisi teks sapaan dan ringkasan cuaca (opsional). Bagian bawah berisi *grid* atau *list* artikel perawatan.
* **Halaman Kamera:** Tampilan *full-screen* kamera dengan garis bingkai (*guideline frame*) di tengah layar agar pengguna memosisikan daun dengan tepat.
* **Halaman Hasil Diagnosis:** Gambar hasil *crop* daun di bagian atas, dilanjutkan dengan blok teks informasi (Nama Penyakit, Akurasi) dengan *badge* warna (Merah jika sakit parah, Kuning jika ringan), diikuti oleh *list* langkah penanganan.