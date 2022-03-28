* Encoding: UTF-8.
*1. Obejrzymy dane
    * Sprawdzmy srednie. 
    MEANS TABLES=Sepal.Length BY Species 
      /CELLS=MEAN COUNT STDDEV.
    
    *Wykres pudelkowy.
    EXAMINE VARIABLES=Sepal.Length BY Species 
      /PLOT BOXPLOT  
      /COMPARE GROUPS 
      /STATISTICS NONE  
      /NOTOTAL.

*2. Test T-studenta - jednoczynnikowy.
    
    * Filtr Gatunek Setosa.
    COMPUTE filter_$ = (Species = "setosa"). 
    FILTER BY filter_$.
    
    * Test - hipoteza średnia jest równa 5.7.
    T-TEST 
      /TESTVAL=5.7 
      /MISSING=ANALYSIS 
      /VARIABLES=Sepal.Length 
      /ES DISPLAY(FALSE) 
      /CRITERIA=CI(.95).

    * Test - hipoteza średnia jest równa 5.0.
    T-TEST 
      /TESTVAL=5.0 
      /MISSING=ANALYSIS 
      /VARIABLES=Sepal.Length 
      /ES DISPLAY(FALSE) 
      /CRITERIA=CI(.95).

     FILTER OFF.
    
    * Aplikacja Shiny - hipotezy:
    * https://antoinesoetewey.shinyapps.io/statistics-201/
    
    * Ćwiczenia -  do przetestowania:. 
    * versicolor - wartości: 5.5, 5.8, 6.1
    * virginica -  wartości: 6.5, 6.7, 7.0

*3. Test T-studenta - dwie niezależne populacje.

    * Skrócę lekko nazwy.
    COMPUTE species_short = 0.
    DO IF (Species EQ "setosa").
        COMPUTE species_short = 1.
    ELSE IF (Species EQ "versicolor").
        COMPUTE species_short = 2.
    ELSE IF (Species EQ "virginica").
        COMPUTE species_short = 3.
    END IF.
    EXECUTE.
    
    * Filtr - wszystko bez gatunku Setosa.
    COMPUTE filter_$=(Species  ~=  "setosa").
    FILTER BY filter_$.
    
    * Test t - hipoteza średnia w dwóch grupach jest inna.
    T-TEST GROUPS=species_short(2, 3)
        /MISSING=ANALYSIS
        /VARIABLES=Sepal.Length
        /ES DISPLAY(FALSE)
        /CRITERIA=CI(.95).
    
    FILTER OFF.

    * Ćwiczenia -  do przetestowania:. 
    * Grupy 1 i 2

* Czy Rozkład jest normalny? 
    *Wykres QQ - rozkład normalny.
    * Ciekawy opis na https://towardsdatascience.com/q-q-plots-explained-5aa8495426c0 .
    EXAMINE VARIABLES=Sepal.Length BY Species
      /PLOT NPPLOT
      /NOTOTAL.
    
    * Filtr Gatunek Setosa.
    COMPUTE filter_$ = (Species = "setosa"). 
    FILTER BY filter_$.
    
    * Test Nieparametryczny Kołmogorowa-Smirnova - Hipoteza rozkład jest normalny. 
    NPAR TESTS 
      /K-S(NORMAL)=Sepal.Length 
      /MISSING ANALYSIS 
      /KS_SIM CIN(99) SAMPLES(10000) NONORMAL.
    
    FILTER OFF.

*3. ANOVA - hipoteza: równe średnie w kilku populacjach.
    ONEWAY Sepal.Length BY species_short 
      /MISSING ANALYSIS 
      /CRITERIA=CILEVEL(0.95).
    
    * Diagnostyka - test homogeniczności wariancji - hipoteza: są równe w każdej grupie. 
    ONEWAY Sepal.Length BY species_short 
      /STATISTICS HOMOGENEITY 
      /MISSING ANALYSIS 
      /CRITERIA=CILEVEL(0.95) 
      /POSTHOC=TUKEY ALPHA(0.05).
