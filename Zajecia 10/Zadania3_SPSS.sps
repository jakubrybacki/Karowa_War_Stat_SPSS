* Encoding: UTF-8.
*Dzisiaj będziemy pracować na zbiorze danych muzycznych z serwisu Kaggle.com:
* https://www.kaggle.com/datasets/vicsuperman/prediction-of-music-genre

* Zadanie 1: Dane zawierają brakujące wartośici - ustaw je w pliku:
 * W kolumnie duration_ms -> -1
 * W kolumnie tempo -> -99 
 * W kolumnie instrumentalness -> -99.
 

* Zadanie 2: Przygotuje tabelę krzyżową, ktora zlicza tonację (key) dla różnych gatunkow muzyki. Przedstaw dane procentowo. 
*     W Pierwszej tabeli w wierszach, w drugiej tabeli w kolumnach. 


* Zadanie 3: Przekształć zmienną duration_ms, tak aby pokazywała liczbę sekund a nie milisekund (podziel przez 1000). 
*  Policz średni czas dla utworów różnych typów. 


* Zadanie 4: Czy Hip-hop i Rap mają średnio podobny czas trwania piosenek - sprawdź za pomocą testu T. 
 * Zrekoduj zmienną pomocniczą.
* Jaka jest hipoteza zerowa testu? Jaką decyzję podejmiemy oraz na jakiej podstawie?.


* Zadanie 5: Stwórz filtr, ktory wybierze wyłącznie muzykę klasyczną. Sprawdź czy długość piosenek ma 
 * rozkład normalny? A może jej logarytm?.
    

* Zadanie 6 - stworz zmienna będącą logarytmem długości w minutach, Zrób regresję takiej zmiennej na: 
* Głośność (loudness) 
* Logarytm ze zmiennej tempo 
* Jak zinterpretować parametry modelu?. 
      

* Zadanie 7 - Wyłącz filtr - sprawdz średnie oceny popularności po typach muzyki..
    
 
* Zadanie 8 - przeprowadź analizę ANOVA, gdzie sprawdzimy czy popularność rocku, hip-hopu i rapu jest taka sama..
* Jaka jest hipoteza zerowa? Jaką decyzję podejmiemy na podstawie wydruku?.
 

* Zadanie 9 - stworz regresje, ktora wyjasni popularnosc w zależności od długości piosenki i energicznośc i tempai. 

