# System Identification using ARX Model & RLS Algorithm 📉

Bu proje, bilinmeyen bir dinamik sistemin matematiksel modelini, giriş-çıkış verilerini kullanarak oluşturmak amacıyla geliştirilmiştir. **Sistem Tanımlama (System Identification)** tekniklerinden ARX (AutoRegressive with Exogenous input) yapısı ve **Recursive Least Squares (RLS)** algoritması kullanılmıştır.

## 🎯 Proje Amacı
Verilen "Black Box" (Kara Kutu) bir sistemin giriş ($u$) ve çıkış ($y$) verilerini kullanarak, sistemin transfer fonksiyonu katsayılarını ($a_1, a_2, b_1, b_2$) gerçek zamanlıya yakın bir yöntemle tahmin etmek.

Kullanılan model yapısı:
$$y(k) + a_1 y(k-1) + a_2 y(k-2) = b_1 u(k-1) + b_2 u(k-2)$$

## ⚙️ Teknik Detaylar
* **Algoritma:** Recursive Least Squares (RLS) ile parametre tahmini.
* **Model:** 2. Dereceden ARX Modeli.
* **Veri Seti:** `system_data.mat` (Gürültülü sistem yanıtı verisi).
* **Araçlar:** MATLAB.

## 📊 Sonuçlar
Kod çalıştırıldığında, algoritma her adımda parametreleri güncelleyerek gerçek sistem çıkışına yakınsamaktadır. Aşağıdaki grafikte; tahmin edilen çıkışın ($y_{est}$) gerçek çıkışla ($y$) örtüştüğü ve parametrelerin ($a$ ve $b$ değerleri) belirli değerlere yakınsadığı görülmektedir.

<img width="698" height="626" alt="identification_results" src="https://github.com/user-attachments/assets/67c71ab6-5a04-45aa-a76c-02d3bc50fa25" />

## 🚀 Kurulum ve Çalıştırma
1.  Repoyu klonlayın.
2.  MATLAB'da `arx_identification.m` dosyasını açın.
3.  `system_data.mat` dosyasının aynı klasörde olduğundan emin olun.
4.  Kodu çalıştırın (Run).

---
*Bu çalışma, ME 4022 Control Systems II dersi kapsamında Sistem Tanımlama uygulaması olarak yapılmıştır.*
