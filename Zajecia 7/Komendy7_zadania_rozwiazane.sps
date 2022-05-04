* Encoding: UTF-8.
* Link do danych: 
*   https://www.kaggle.com/datasets/camnugent/california-housing-prices

* Zadanie 1 
* Stwótrz model, ktory pokaze o ile procent zmieni sie wartosc nieruchomosci, w ktorej mieszkali 
* Kalifornijczycy w momencie gdy dochod zmieni sie o 1%.
    COMPUTE LOG_median_house_value = LN(median_house_value). 
    COMPUTE LOG_median_income = LN(median_income). 
    EXECUTE.

    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT LOG_median_house_value
      /METHOD=ENTER LOG_median_income.

* Zadanie 2 
 Doloz do modelu informacje czy mieszkanie znajduja sie blisko wybrzeza. O ile procent rosnie cena?.
    COMPUTE kolo_wody = 0.

    DO IF (ocean_proximity EQ "NEAR BAY").
        COMPUTE kolo_wody = 1.
    ELSE IF (ocean_proximity EQ "ISLAND").
        COMPUTE kolo_wody = 1.
    ELSE IF (ocean_proximity EQ "NEAR OCEAN").
        COMPUTE kolo_wody = 1.
    ELSE IF (ocean_proximity EQ "<1H OCEAN").
        COMPUTE kolo_wody = 1.
    END IF.
    EXECUTE.

    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT LOG_median_house_value
      /METHOD=ENTER LOG_median_income kolo_wody.
*Zadanie 3  
# Sprawdzmy na ile nasze wnioski pokrywaja sie z prostymi tabelami krzyzowymi - chcemy znalezc:
#   srednia cene dla mieszkan roznych typow. 
MEANS TABLES=median_house_value BY kolo_wody
  /CELLS=MEAN COUNT STDDEV.
  
* Zadanie 4
Wyswietlmy reszty naszego modelu - czy rozrzut wielkosci bledu jest zalezne od ceny mieszkania.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT LOG_median_house_value
  /METHOD=ENTER LOG_median_income kolo_wody
  /SCATTERPLOT=(*SDRESID ,LOG_median_house_value).
  
* Zadanie 5
Powtórzmy estymacje naszego modelu dla osob wylacznie o dochodach ponizej 8 tys.USD.
USE ALL.
COMPUTE filter_$=(median_income <= 8).
VARIABLE LABELS filter_$ 'median_income <= 8 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT LOG_median_house_value
      /METHOD=ENTER LOG_median_income kolo_wody.

* Zadanie 6
* Zarowno model statystyczny oraz tabele krzyzowe pokazuja ze ceny mieszkan w zatoce i przy oceanie sa podobne
* Wykonajmy box plot i formalny test t.
    FILTER OFF.
    COMPUTE zatoka_ocean = 0.

    DO IF (ocean_proximity EQ "NEAR BAY").
        COMPUTE zatoka_ocean  = 1.
    ELSE IF (ocean_proximity EQ "NEAR OCEAN").
        COMPUTE zatoka_ocean  = 2.    
    END IF.
    EXECUTE.

T-TEST GROUPS=zatoka_ocean(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=median_house_value
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Zadanie 7 
* Stworzmy troche prostszy model - na poziomach zmiennych. Zobaczmy jak na cene mieszkan wplywaja 
* wspolrzedne geograficzne i wiek mieszkania.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT median_income
  /METHOD=ENTER longitude latitude housing_median_age.

* Zadanie 8 
* Sprawdzmy czy tak samo beda zachowywac sie wyniki dla osób o najnizszych dochodach
* Badamy dochody ponizej 2 tys. 








