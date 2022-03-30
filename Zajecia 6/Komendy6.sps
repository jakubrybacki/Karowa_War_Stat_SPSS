* Encoding: UTF-8.

* Chcemy odpowiedzieć na pytania  - jak zwiększyć użycie narzędzi wśród nauczycieli. (TCICTUSE).
* Dla uproszczenia przekoduje pare zmiennych.
RECODE TC005Q01NA (2 = 0) (1=1) INTO PLEC.
RECODE TC021Q01NA (2 = 0) (1=1) INTO ROZWOJ.
RECODE TC176Q02HA (1=0) (2=1) (3=2) (4=3) (5 = 4) INTO SOCIAL_MEDIA.

COMPUTE START_KARIERY = 2018 - TC007Q02NA. 
EXECUTE.

*1. Regresja liniowa - pierwsza krew. 
    * Na początku sprawdzmy czy kobiety czeasciej od mezczyzn korzystaja z technik informatycznych.
    REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC.
    
    * Dodajemy druga zmienna - wiek.
    REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC TC007Q02NA.
    
    * I trzecią - uczestnictwo w szkoleniach .
    REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC TC007Q02NA ROZWOJ. 

*2. Regresja - przekształcenia danych. 
    * Zmieniamy zakodowanie zmiennej dotyczacej doświadczenia.   
    REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC ROZWOJ START_KARIERY. 

    * Dlaczego zmienila sie nam stala?.
    AGGREGATE outfile * mode addvariables
    /START_KARIERY_SREDNIA = MEAN(START_KARIERY).

    COMPUTE START_KARIERY_ODSREDNIONY = START_KARIERY - START_KARIERY_SREDNIA.
    EXECUTE.

    REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC ROZWOJ START_KARIERY_ODSREDNIONY.

    * Czy mozemy do równania wlozyc osobna srednia?. 
   REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC ROZWOJ START_KARIERY START_KARIERY_SREDNIA.

*2. Regresja - Zmienne porządkowe.
    * Potraktujmy zmienna porzadkową jako ciągłą ilościową.
   REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC ROZWOJ START_KARIERY SOCIAL_MEDIA.
     
    * Pomyslmy - rozne poziomy moga odpowiadać innym zachowaniom - przekodujmy to na 4 rozne zmienne. 
    COMPUTE SOCIAL_MEDIA_1 = 0.
    COMPUTE SOCIAL_MEDIA_2 = 0.
    COMPUTE SOCIAL_MEDIA_3 = 0.
    COMPUTE SOCIAL_MEDIA_4 = 0.
    
     DO IF (SOCIAL_MEDIA EQ 1).
        COMPUTE SOCIAL_MEDIA_1 = 1.
    ELSE IF (SOCIAL_MEDIA EQ 2).
        COMPUTE SOCIAL_MEDIA_2 = 1.
    ELSE IF (SOCIAL_MEDIA EQ 3).
        COMPUTE SOCIAL_MEDIA_3 = 1.
    ELSE IF (SOCIAL_MEDIA EQ 4).
        COMPUTE SOCIAL_MEDIA_4 = 1.
    END IF.
    EXECUTE.    

    * Wrzucmy je teraz do regresji.
   REGRESSION 
      /MISSING LISTWISE 
      /STATISTICS COEFF OUTS R ANOVA 
      /CRITERIA=PIN(.05) POUT(.10) 
      /NOORIGIN 
      /DEPENDENT TCICTUSE 
      /METHOD=ENTER PLEC ROZWOJ START_KARIERY SOCIAL_MEDIA_1 SOCIAL_MEDIA_2 SOCIAL_MEDIA_3 SOCIAL_MEDIA_4.
