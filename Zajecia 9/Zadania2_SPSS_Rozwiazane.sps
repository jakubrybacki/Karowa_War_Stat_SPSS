* Encoding: UTF-8.
*Dane
*https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/

* Zadanie 1: Stwórz tabelę czestotliwości dla zmiennej opisującej jakość (quality).
FREQUENCIES VARIABLES=quality
  /ORDER=ANALYSIS.

* Zadanie 2. Przedstaw odsetki  w zależności od typu wina (białe / czerwone). 
CROSSTABS
  /TABLES=quality BY Typ
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN
  /COUNT ROUND CELL.

* Zadanie 3 Dodaj do wyniku test chi-squared oraz informacje o różnicach między faktycznymi i oczekiwanymi wartościami .
CROSSTABS
  /TABLES=quality BY Typ
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED 
  /COUNT ROUND CELL
  /HIDESMALLCOUNTS COUNT=5.

* Zadanie 4: Przedstaw średnią zawartość alkoholu w winach różnych typów (białe, czerwone). 
MEANS TABLES=alcohol BY Typ
  /CELLS=MEAN COUNT STDDEV.

* Zadanie 5: Przedstaw wykres Box-plot obydwu typów wina. 
EXAMINE VARIABLES=alcohol BY Typ
  /PLOT BOXPLOT 
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* Zadanie 6: Wykonaj testy t-które sprawdzą czy średnia zawartość alkoholu jest taka sama między białymi i czerwownymi winami. 
*    Stwórz  zmienna gdzie opisy białe / czerwone zastąpia wartości 1 i 2. 
RECODE Typ ('Czerwone'=1) (ELSE=2) INTO Typ_liczba.
VARIABLE LABELS  Typ_liczba 'Białe czy czerwone'.
EXECUTE.

T-TEST GROUPS=Typ_liczba(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=alcohol
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Zadanie 7: Stwórz zmienną która przyjmie wartość: 
    - 0 - jeżeli zawartość alkoholuj jest mniejsza niż 9%
    - 1 - jezeli zawartość alkoholu jest  między 9 i 11%
    - 2 - jezeli zawartość przekracza 11%. 
* Za pomocą kodu przyporządkuj etykiety Słabe / Normalne / Mocne poszczególnym wartościom. 

COMPUTE zawartosc_slowna = 0.

 DO IF (alcohol  > 11).
    COMPUTE zawartosc_slowna  = 2.
ELSE IF (alcohol  > 9).
    COMPUTE zawartosc_slowna = 1.
END IF.
EXECUTE. 

VARIABLE LABELS zawartosc_slowna "Zawartość alkoholu - 3 kalsy".
ADD VALUE LABELS zawartosc_slowna  
   0 "Słabe"
   1 "Normalne"
   2 "Mocne".

* Zadanie 8: Policz średnie oceny dla każdej z 3 grup. 
MEANS TABLES=quality BY zawartosc_slowna
  /CELLS=MEAN COUNT STDDEV.

* Zadanie 9: Przeprowadz analize ANOVA, która sprawdzi czy oceny wina dla 3 grup są sobie równe. 
* Jaka jest decyzja w teście przy poziome istotności 0.05.
ONEWAY quality BY zawartosc_slowna
  /ES=OVERALL
  /MISSING ANALYSIS
  /CRITERIA=CILEVEL(0.95).

* Stwórz regresje w której zawartość alkoholu wyjaśnisz przez Ph, wielkość cukru (residualsugar), siarczany (sulphates) oraz coś o zakwaszeniu (fixed acidity)
* Któe zmienne są istotne, a które nie. O ile wzrośnie / spadnie zawartość alkoholu jeżeli miernik dotyczący siarczanów powiększy się o 1?.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcohol
  /METHOD=ENTER pH fixedacidity residualsugar sulphates.
