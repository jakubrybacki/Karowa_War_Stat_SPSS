* Encoding: UTF-8.
* Link do danych: 
*   https://www.kaggle.com/datasets/kumarajarshi/life-expectancy-who

* Zebrane dane stanowią tzw. panel - informacje dotyczą zarówno krajów, jak i poszczególnych lat. 
* Takie dane analizuje się trochę inaczej niż prostą regresją. Będziemy chcieli informacje tylko z najnowszego roku. 
COMPUTE filter_$ = (Year EQ 2015). 
EXECUTE.
FILTER BY filter_$.

* Na poprzednich zajęciach kształtowaliśmy prostę regresje. Obecnie skoncentrujemy się na przekształcaniach danych. 
* Będą one nadawć zupełnie odrębne interpretacje parametrom. 

* Miodel 1 - Standardowa regresja
    * Zbudujmy prosty model, tłumaczący oczekiwaną liczbę lat życia od okresu edukacji. 
    * Interpretacja modelu: Dodatkowy rok edukacji wpływa na wzrost oczekiwanego czasu życia o X lat. 
    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT Lifeexpectancy
      /METHOD=ENTER Schooling
      /SAVE pred(pred_1).
    
 * Miodel 2 - Elastyczność.
    * Przekształćmy obie zmienne do logarytmów naturalnych. 
    COMPUTE LOG_Lifeexpectancy = LN(Lifeexpectancy). 
    COMPUTE LOG_Schooling = LN(Schooling). 
    EXECUTE.

    * Stwórzmy model opisujący proces w oparciu o nowe zmienne. 
    * Interpretacja: Wydłużenie czasu szkolnictwa o 1 procent średnio powiększa oczekiwana długość życia o XX procent. 
    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT LOG_Lifeexpectancy
      /METHOD=ENTER LOG_Schooling
      /SAVE pred(pred_2).

* Miodel 3 - Semi - Elastyczność.
    * Stwórzmy model w następującej kombinacji - wyjaśniamy logarytm zmiennej za pomocą niezlogaytmowanej wartości. 
    * Interpretacja: Wydłużenie czasu szkolnictwa o 1 rok średnio powiększa oczekiwana długość życia o (wielkość parametru * 100) procent. 
    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT LOG_Lifeexpectancy
      /METHOD=ENTER Schooling
      /SAVE pred(pred_3).
 
* Test: Czy modele 1, 2 i 3 dają rózne wyniki?
    * Sprawdzimy czy predykcje modeli roznia sie.
    COMPUTE pred_2 = EXP(pred_2). 
    COMPUTE pred_3 = EXP(pred_3). 
    EXECUTE.
    
    * Zmiana etykiet.
    VARIABLE LABELS  pred_1  "MODEL - Prosty".
    VARIABLE LABELS  pred_2  "MODEL - ELASTYCZNOSC".
    VARIABLE LABELS  pred_3  "MODEL - SEMI - ELASTYCZNOSC".
    
    * Czy średnie w prognozach są równe?. 
    T-TEST PAIRS=pred_1 pred_2 pred_1 WITH pred_2 pred_3 pred_3 (PAIRED)
      /ES DISPLAY(TRUE) STANDARDIZER(SD)
      /CRITERIA=CI(.9500)
      /MISSING=ANALYSIS.

* Model 4 - przemnozone dane,
    * Zalozmy ze zamiast lat chcemy miesiace edukacji. 
    COMPUTE Schooling_Month = Schooling * 12. 
    EXECUTE.
    
    * Estymujemy pierwszy model z nową zmienną. Czy wynik predykcji będzie różny?.
    REGRESSION
      /MISSING LISTWISE
      /STATISTICS COEFF OUTS R ANOVA
      /CRITERIA=PIN(.05) POUT(.10)
      /NOORIGIN 
      /DEPENDENT Lifeexpectancy
      /METHOD=ENTER Schooling_Month
      /SAVE pred(pred_4).

* Wykresy - homoskedastyczność.
    * Poprawne wnioskowanie wymaga, aby odchylenia standardowe reszt były takie same niezależnie od wielkości zmiennej. 
    * W naszym przypadku nie jest to spełnione - odchylenia są większe dla obserwacji .
    REGRESSION | 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT Lifeexpectancy 
      /METHOD=ENTER Schooling 
      /SCATTERPLOT=(*ZRESID ,Lifeexpectancy).
    
    
    
    