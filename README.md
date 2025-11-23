# Control Systems Engineering Portfolio 🕹️

Bu depo, Marmara Üniversitesi Makine Mühendisliği lisans eğitimi boyunca aldığım **Sistem Dinamiği** ve **Kontrol Sistemleri** dersleri kapsamında geliştirdiğim projeleri, ödevleri ve simülasyon çalışmalarını içermektedir.

Buradaki çalışmalar, teorik kontrol konseptlerinin (PID, Root Locus, State-Space) gerçek veya modellenmiş sistemler üzerinde MATLAB/Simulink kullanılarak uygulanmasını kapsamaktadır.

## 📚 Akademik Kapsam

Bu portföy, aşağıdaki derslerin çıktılarını içerir:

### 1. ME 3021 – System Dynamics & Control
* **Odak:** Dinamik sistemlerin matematiksel modellenmesi, Transfer Fonksiyonları, Blok Diyagramları, Zaman ve Frekans Cevabı Analizleri, PID Kontrolör Tasarımı.
* **Yetkinlikler:** Laplace Dönüşümü, Bode Diyagramları, Routh-Hurwitz Kriteri.

### 2. ME 4022 – Control Systems II
* **Odak:** Dijital Kontrol Sistemleri, Durum Uzayı (State-Space) Analizi, Sistem Tanımlama (System Identification) ve İleri Kontrol Teknikleri.
* **Yetkinlikler:** Ayrık Zamanlı Sistemler (z-transform), Gözlemci Tasarımı (Observer Design), Parametre Tahmini (RLS/ARX).

---

## 📂 Projeler ve Uygulamalar

Aşağıda, bu depoda yer alan projelerin listesi ve kısa açıklamaları bulunmaktadır. Detaylı teknik raporlar ve kodlar ilgili klasörlerin içindedir.

### 🔹 [Basic System Identification (1st & 2nd Order)](./System-Identification-Basics)
*(Ders: ME 4022)*
* **Açıklama:** Bilinmeyen sistemlerin zaman domenindeki (Time-Domain) davranışlarını analizerek Transfer Fonksiyonu parametrelerinin ($K, \tau, \zeta, \omega_n$) tahmin edilmesi.
* **Yöntem:** Adım Yanıtı (Step Response) Analizi ve Parametre Tahmini.

### 🔹 [System Identification using ARX](./System-Identification-ARX)
*(Ders: ME 4022)*
* **Açıklama:** "Kara Kutu" (Black Box) bir sistemin giriş-çıkış verilerini kullanarak matematiksel modelini oluşturmak için **Recursive Least Squares (RLS)** algoritması ve **ARX** model yapısı kullanılmıştır.
* **Araçlar:** MATLAB (System Identification Toolbox).

---

## 🛠️ Kullanılan Teknolojiler
* **Yazılım:** MATLAB, Simulink
* **Alanlar:** Klasik Kontrol, Modern Kontrol, Sistem Modelleme, Sinyal İşleme

---
*Bu depo, mühendislik yetkinliklerimi sergilemek amacıyla düzenli olarak güncellenmektedir.*
