* Encoding: UTF-8.
* Instrukcja COMPUTE. 
    * Przykładowa zmienna ilościowa.
    COMPUTE  ZMIENNA = 1.
    EXECUTE.  
    
    % Przykład - podwyżka.
    COMPUTE WIEK_DZIECKA= AGE -  AGEKDBRN.
    EXECUTE.  
    
* Instrukcja FORMATS. 
    * Dodajemy zmienne. 
    VARIABLE LABELS WIEK_DZIECKA "Deklarowany wiek dziecka".
    FORMATS WIEK_DZIECKA(F3.2).
    
    * Policzmy częstości.
    FREQUENCIES VARIABLES= WIEK_DZIECKA
      /ORDER=ANALYSIS.
    
    * Zmieniamy formatowanie i ponawiamy częstości. 
    FORMATS WIEK_DZIECKA(F3.0).
    FREQUENCIES VARIABLES= WIEK_DZIECKA
      /ORDER=ANALYSIS.
    
* zmienne warunkowe - Instrukcja IF.
     * Sprawdzamy czy pierwsze dziecko jest pełnoletnie.
     COMPUTE NIEPELNOLETNI = 0.
     IF (RANGE(WIEK_DZIECKA, 0, 18)) NIEPELNOLETNI = 1.
     EXECUTE.

    FREQUENCIES VARIABLES= NIEPELNOLETNI 
      /ORDER=ANALYSIS.

    * Dwa warunki - instrukcja LUB. 
    IF (WIEK_DZIECKA < 0 OR WIEK_DZIECKA > 70) DZIWNE_PRZYPADKI = 1. 
    EXECUTE.
    
     FREQUENCIES VARIABLES= DZIWNE_PRZYPADKI 
      /ORDER=ANALYSIS.

    * Dwa warunki - Instrukcja ORAZ. 
    IF (SHOTGUN = 1 AND SEXNOW = 1) UZBROJONA_KOBIETA = 1. 
    EXECUTE.

    * Różne operatory: https://www.spss-tutorials.com/spss-basic-operators/ . 

* Złożone zapytania - wygenerujemy napis .
    STRING SZKOLA(A10).

    DO IF (RANGE(WIEK_DZIECKA, 0, 6)).
        COMPUTE SZKOLA = "PRZEDSZKOLE".
    ELSE IF (RANGE(WIEK_DZIECKA, 7, 13)).
        COMPUTE SZKOLA = "PODSTAWOWA".
    ELSE IF (RANGE(WIEK_DZIECKA, 13, 18)).
        COMPUTE  SZKOLA = "WYZEJ".
    ELSE.
        COMPUTE  SZKOLA = "ND".
    END IF.
    EXECUTE.

    * Policzmy częstości.
    FREQUENCIES VARIABLES= SZKOLA
      /ORDER=ANALYSIS.

* Skasujmy niepotrzebne zmienne. 
    DELETE VARIABLES DZIWNE_PRZYPADKI UZBROJONA_KOBIETA.

* Instrukcja Filter.
*    Ćwiczenie - czy rozkład odpowiedzi o moralnym prawie do aborcji jest inny wśród osób z dziecmi w wieku szkolnym niz u pozostalych.
    FREQUENCIES VARIABLES= ABMORAL    
      /ORDER=ANALYSIS.

    FILTER BY NIEPELNOLETNI.
    FREQUENCIES VARIABLES= ABMORAL    
      /ORDER=ANALYSIS.

    * Wyłaczamy filtr.
    FILTER OFF.


