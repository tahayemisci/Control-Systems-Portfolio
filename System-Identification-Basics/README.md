# System Identification: First & Second Order Systems 📉

Bu proje, "Kara Kutu" (Black Box) olarak verilen bilinmeyen dinamik sistemlerin matematiksel modellerinin çıkarılması üzerine bir çalışmadır. Birinci ve ikinci dereceden sistemlerin adım yanıtı (step response) verileri analiz edilerek sistem parametreleri tahmin edilmiştir.

## 🎯 Proje Amacı
Verilen gürültülü sensör verilerini kullanarak sistemlerin Transfer Fonksiyonlarını oluşturmak.

### Analiz Edilen Sistemler:
1.  **Birinci Derece Sistem (First Order):**
    * Zaman Sabiti ($\tau$) ve Kazanç ($K$) hesabı.
    * Model: $G(s) = \frac{K}{\tau s + 1}$
2.  **İkinci Derece Sistem (Second Order):**
    * Sönüm Oranı ($\zeta$) ve Doğal Frekans ($\omega_n$) hesabı.
    * Aşım (Overshoot) ve Yerleşme Zamanı (Settling Time) analizi.
    * Model: $G(s) = \frac{K \omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$

## 📂 Dosya İçeriği
* `parameter_estimation.m`: MATLAB hesaplama ve görselleştirme kodu.
* `data_first_order.mat`: 1. derece sistemin giriş-çıkış verisi.
* `data_second_order.mat`: 2. derece sistemin giriş-çıkış verisi.

## 📊 Yöntem
MATLAB kullanılarak ham veriler görselleştirilmiş, sistemin karakteristik özelliklerine (Maximum Overshoot, Peak Time vb.) dayalı analitik hesaplamalarla transfer fonksiyonu katsayıları türetilmiştir. Elde edilen modelin yanıtı ile gerçek veri karşılaştırılarak doğrulama (validation) yapılmıştır.

---
*Bu çalışma, ME 4022 Control Systems II dersi kapsamında yapılmıştır.*
