* Encoding: UTF-8.
* Trochę o pisaniu w Syntax
* https://www.spss-tutorials.com/spss-syntax-beginners-tutorial/ 

* Encoding: UTF-8.
GET 
  FILE='C:\Users\Jakub\OneDrive\Karowa\Warsztaty statystyczne - semestr 2\ESS9PL.spss\ESS9PL.sav'. 
DATASET NAME ZbiórDanych1 WINDOW=FRONT.

* Tabele czestosci.
FREQUENCIES VARIABLES=trstplt 
  /ORDER=ANALYSIS.

*Złe praktyki.
FRE trstplt.

* WIele zmiennych.
FREQUENCIES VARIABLES=trstplt trstprt
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

* Czy przywiazanie do kraju determinuje ufność do polityków?. 
MEANS TABLES=trstplt BY atchctr 
  /CELLS=MEAN COUNT STDDEV.

* Regresja liniowa.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT trstplc
  /METHOD=ENTER happy health.

