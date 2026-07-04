# Plant Doctor Application

Aplikasi Flutter untuk mendeteksi penyakit tanaman melalui foto, memberikan informasi gejala, penanganan, dan riwayat diagnosis.

## Persyaratan Sistem

Sebelum menjalankan project, pastikan perangkat Anda sudah memasang:

- Flutter SDK (versi terbaru yang didukung project)
- Git
- Android Studio atau VS Code dengan extension Flutter/Dart
- Emulator Android atau perangkat fisik yang terhubung

Periksa instalasi Flutter terlebih dahulu:

```bash
flutter doctor
```

Jika ada yang belum terpasang, ikuti instruksi yang muncul.

## Clone Repository

Jalankan perintah berikut di terminal:

```bash
git clone https://github.com/Alds323721/Plant_Doctor_Apliication.git
cd Plant_Doctor_Apliication
```

## Install Dependency

Setelah masuk ke folder project, jalankan:

```bash
flutter pub get
```

## Menjalankan Aplikasi

1. Pastikan emulator sudah aktif atau device terhubung.
2. Jalankan aplikasi dengan perintah:

```bash
flutter run
```

Jika Anda ingin melihat daftar device yang tersedia:

```bash
flutter devices
```

## Build Aplikasi

Untuk membuat file APK:

```bash
flutter build apk
```

Untuk build aplikasi web:

```bash
flutter build web
```

## Struktur Proyek

- lib/main.dart — entry point aplikasi
- lib/screens/ — halaman UI aplikasi
- lib/services/ — logika API, storage, dan konektivitas
- lib/models/ — model data
- lib/config/ — konfigurasi tema dan konstanta

## Troubleshooting

Jika terjadi error saat menjalankan project, coba langkah berikut:

```bash
flutter clean
flutter pub get
flutter doctor
```

## Kontribusi

Jika ingin mengembangkan project ini lebih lanjut, silakan fork repository ini lalu buat pull request.
