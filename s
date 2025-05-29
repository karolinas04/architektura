Tabelka z wynikami 

Metoda dodawania
Czas wykonania [s]
scalar_add
3.84634
sse_add
2.08004
avx_add
1.24117
avx512_add
2.90757


Komentarz do wyników
scalar_add — najwolniejsze, ponieważ każda operacja dodawania była wykonywana oddzielnie, bez wsparcia SIMD.


sse_add — znaczące przyspieszenie dzięki jednoczesnemu przetwarzaniu 4 liczb typu float w jednym rejestrze.


avx_add — najlepszy wynik, dzięki wykorzystaniu rejestrów 256-bitowych, umożliwiających równoległe dodawanie 8 wartości typu float.


avx512_add — pomimo zastosowania rejestrów 512-bitowych (16 wartości float), wynik jest gorszy niż AVX. Może to wynikać z:


niedostatecznej optymalizacji kodu dla AVX512,


mniejszej dostępności jednostek AVX512 na testowanej platformie,


większego narzutu na inicjalizację i zarządzanie tymi rejestrami.


Wnioski
Największy zysk czasowy osiągnięto przy użyciu AVX. Wyniki potwierdzają, że odpowiedni dobór instrukcji SIMD ma kluczowe znaczenie dla wydajności, ale należy także uwzględniać możliwości sprzętowe danej platformy (np. czy AVX512 faktycznie jest w pełni obsługiwane i optymalizowane).
