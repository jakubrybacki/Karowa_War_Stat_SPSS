* Encoding: UTF-8.
* Statystyki opisowe. 
DESCRIPTIVES VARIABLES=F132 
  /STATISTICS=MEAN STDDEV VARIANCE RANGE MIN MAX SEMEAN.

* Seksualność vs. religia - podstawowa wersja jest mało użyteczna. 
CROSSTABS 
  /TABLES=F132 BY F025 
  /FORMAT=AVALUE TABLES 
  /CELLS=COUNT 
  /COUNT ROUND CELL.

* Na szczęście istnieją podsumowania jak w tabeli przestawnej - z iinterfejsu mi to zawsze zle wychodzilo.
 CROSSTABS
  /TABLES=F132 BY F025
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.

* Niemniej od czego jest kod - usunąłem COUNT.
CROSSTABS
  /TABLES=F132 BY F025
  /FORMAT=AVALUE TABLES
  /CELLS= COLUMN
  /COUNT ROUND CELL.

* W raporcie chce napisac prostszy przekaz - potrzebuje sformatować zmienną. 
* https://www.spss-tutorials.com/spss-recode-command/    ......
RECODE F132 (1,2,3 = 1) (4,5,6 = 2) (7,8,9 = 3) (10 = 4) INTO  PRZYGODNY_SEKS.

* Instrukcja thru pomoże jak wystepuje wiecej liczb.
RECODE F132 (1 thru 5 = 0) (6 thru 10 = 1) INTO  PRZYGODNY_SEKS_BINARNY.

* Nadajemy zmiennym etykiety.
VARIABLE LABELS PRZYGODNY_SEKS 'Stosunek do przygodnego seksu - 4 poziomy'.
VARIABLE LABELS PRZYGODNY_SEKS_BINARNY 'Stosunek do przygodnego seksu - zmienna binarna'.

* Nadajemy znaczenie poziomom.
ADD VALUE LABELS PRZYGODNY_SEKS  1 'Małe Poparcie'
    2 'Średnie poparcie'
    3 'Duże poparcie'
    4 'Seksoholizm'.
    
ADD VALUE LABELS PRZYGODNY_SEKS_BINARNY  0 'Niższa połowa' 1 'Wyższa połowa'.

* Czestości.
FREQUENCIES VARIABLES= PRZYGODNY_SEKS PRZYGODNY_SEKS_BINARNY    
  /ORDER=ANALYSIS.

* Teraz podwójna tabela ma sens. 
CROSSTABS
  /TABLES=PRZYGODNY_SEKS BY F025
  /FORMAT=AVALUE TABLES
  /CELLS= COUNT COLUMN
  /COUNT ROUND CELL.

* Eksportuj raport wynikowy.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\Jakub\OneDrive\Karowa\Warsztaty statystyczne - semestr 2\Zajecia '+
    '2\Wynik.xlsx'
     OPERATION=CREATEFILE
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.

