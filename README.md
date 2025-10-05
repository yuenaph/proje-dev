erDiagram
MUSTERI {
int id PK
string ad
string soyad
string email
string sehir
date kayit_tarihi
}


URUN {
int id PK
string ad
decimal fiyat
int stok
int kategori_id FK
int satici_id FK
}


KATEGORI {
int id PK
string ad
}


SATICI {
int id PK
string ad
string adres
}


SIPARIS {
int id PK
int musteri_id FK
date tarih
decimal toplam_tutar
string odeme_turu
}


SIPARIS_DETAY {
int id PK
int siparis_id FK
int urun_id FK
int adet
decimal fiyat
}


MUSTERI ||--o{ SIPARIS : "verir"
SIPARIS ||--o{ SIPARIS_DETAY : "içerir"
SIPARIS_DETAY }o--|| URUN : "referans"
KATEGORI ||--o{ URUN : "sahip"
SATICI ||--o{ URUN : "sahip"
