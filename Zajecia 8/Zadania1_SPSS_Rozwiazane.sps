* Encoding: UTF-8.
*Dane:
*https://www.kaggle.com/datasets/nehalbirla/vehicle-dataset-from-cardekho

* Zadanie 1: Wykorzystaj filtr tak, aby dane zawierały wyłącznie transakcje z samochodów wyprodukowanych po roku 2005. 
 USE ALL.
COMPUTE filter_$=(year > 2005).
VARIABLE LABELS filter_$ 'year > 2005 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Zadanie 2. Wykonaj nastepującą tabelę częstości: W wierszach chcemy obserwować kolejne lata (zmienna year). W kolumnach ilość właścicieli (zmienna owner). 
*    Interesuje nas procentowy udział samochodów z danych lat w zależnosci od kategorii - będzie to wymagać podmiany parametrów. .
CROSSTABS
  /TABLES=year BY owner
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN
  /COUNT ROUND CELL.

* Zadanie 3: Jaki jest średni przebieg samochodów (zmienna km_driven) w zależności od typu sprzedawcy (zmienna seller_type).. 
MEANS TABLES=km_driven BY seller_type
  /CELLS=MEAN COUNT STDDEV.

* Zadanie 4: Przedstaw przebieg samochodów w zależności od typy sprzedawcy na wykresie pudełkowym. 
EXAMINE VARIABLES=km_driven BY seller_type
  /PLOT BOXPLOT
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.
 
* Zadanie 5: Czy ceny samochodów podązają rozkłądem normalnym. - wykonaj QQ plot. 
PPLOT
  /VARIABLES=selling_price
  /NOLOG
  /NOSTANDARDIZE
  /TYPE=Q-Q
  /FRACTION=BLOM
  /TIES=MEAN
  /DIST=NORMAL.

* Zadanie 6 : A możę logarytm zmiennej selling_price podąża rozkłądem normalnym? 
*   Wygeneruj taką nową zmienną, a następnie stwórz kolejny QQ plot.
COMPUTE  LOG_Selling_Price = LN(selling_price).
EXECUTE.

PPLOT
  /VARIABLES=LOG_Selling_Price
  /NOLOG
  /NOSTANDARDIZE
  /TYPE=Q-Q
  /FRACTION=BLOM
  /TIES=MEAN
  /DIST=NORMAL.

* Zadanie 7.: Wykorzystaj Formułę RECODE, aby zrobić zmienną porządkową, Typ silnika która przyjmuje :
 ^ 1, gdy samochód ma silnik diesla  
 * 2 gdy silnik jest benzynowy 
*  3 dla LPG.
RECODE fuel ('Diesel'=1) ('Petrol'=2) ('LPG'=3) INTO typ_silnika.
VARIABLE LABELS  typ_silnika 'porządkowy'.
EXECUTE.

* Zadanie 8: Wykonaj test t studenta, który sprawdzi czy średnia cena samochodów z silnikiem diesla jest podobna do samochodów benzynowych.  
*   Napisz jakie są konkluzję testu - przjmij poziom istotności 0.05.
T-TEST GROUPS=typ_silnika(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=selling_price
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Zadanie 9. Stwórz zmienna wiek = 2022 - rok produkcji auta.  
*    Następnie przeprowadz regresję liniową w której cene samochodu objaśniasz przez wiek oraz przebieg pojazdu. 
*    Opisz iinterpretacje parametrów przy wspomnianych zmiennych. 
COMPUTE wiek = 2022 - year.
EXECUTE.
 
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT selling_price
  /METHOD=ENTER km_driven wiek.

* Zadanie 10: Dodaj do modelu zmienne binarne, które opisują, którym z rzędu wlaścicielem był sprzedawca samchodu. 
*     Opisz które zmienne są istotne statystycznie, a które nie - przyjmij poziom istotności 0.05. 
 COMPUTE drugi_wlasciciel = 0.
COMPUTE trzeci_wlasciciel = 0.
COMPUTE czwarty_wlasciciel = 0.

 DO IF (owner EQ "Second Owner").
    COMPUTE drugi_wlasciciel = 1.
ELSE IF (owner EQ "Third Owner").
    COMPUTE trzeci_wlasciciel = 1.
ELSE IF (owner EQ "Fourth & Above Owner").
    COMPUTE czwarty_wlasciciel = 1.
END IF.
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT selling_price
  /METHOD=ENTER km_driven wiek drugi_wlasciciel trzeci_wlasciciel czwarty_wlasciciel. 
    

