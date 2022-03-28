* Encoding: UTF-8.

* 1. Ważenie danych.
    * Na ostatnich zajęciach nuczyliśmy się filtrować dane, aby usuwać zbędne informacje. 
    * W badaniach społecznych często informacje mają różną ważność np. mieszkańcy wielkich miast stanowią większy odsetek społeczeństwa niż wsie.
    * Nauczymy się to odwzorowywać. 
    
    * Zacznijmy od częstotliwości odpowiedzi w pierwszym pytaniu. 
    FREQUENCIES VARIABLES=GAP21Q1_W82
      /ORDER=ANALYSIS.
    
    * Aby włączyć system wag uruchamiamy następujące polecenie.
    WEIGHT BY WEIGHT_W82.
    
    * Uruchomimy jeszcze raz komendę z pierwszym pytaniem - otrzymamy inne wyniki. 
    FREQUENCIES VARIABLES=GAP21Q1_W82
      /ORDER=ANALYSIS.
    
    * Wagę można zdjąc za pomocą komendy:.
    WEIGHT OFF.
    
* 2. Pytania wielokrotnego wyboru.
    * Istnieje możliwość grupowania pytania - w zakładce analiza wybieramy -> wielokrotne odpowiedzi -> Definiuj nazwy zmiennych.
 
    * Zrobimy sobie zestawienie najbardziej popieranych państw przez Amerykanów:.
    MULT RESPONSE GROUPS=$Stosunek_InneNacje (gap21q4_a_w82 gap21q4_b_w82 gap21q4_c_w82 gap21q4_d_w82 
        gap21q4_e_w82 gap21q4_f_w82 (1)) 
      /FREQUENCIES=$Stosunek_InneNacje.

    * Oraz tabelę krzyżową z podziałem na płcie. 
    MULT RESPONSE GROUPS=$Stosunek_InneNacje (GAP21Q4_a_W82 GAP21Q4_b_W82 GAP21Q4_c_W82 GAP21Q4_d_W82 
        GAP21Q4_e_W82 GAP21Q4_f_W82 (1)) 
      /VARIABLES=F_GENDER(1 2) 
      /TABLES=$Stosunek_InneNacje BY F_GENDER 
      /CELLS=TOTAL 
      /BASE=CASES.
    
    * Pytania można układać kategorycznie, ale trzeba przemyśleć sens - w tym wypadku informacja, że repondent z USA zaznacza np. 2,7 odpowiedzi, że 
      lekko popriera jakąś nację / grupę daje niewiele.    
    MULT RESPONSE GROUPS=$Stosunek_InneNacje (gap21q4_a_w82 gap21q4_b_w82 gap21q4_c_w82 gap21q4_d_w82 
        gap21q4_e_w82 gap21q4_f_w82 (1,4)) 
      /FREQUENCIES=$Stosunek_InneNacje.

* 3. Testy statystyczne - Test zgodności Chi-kwadrat. 
    *Zbiory danych PEW nie mają zakodowanych braków danych -  poprawmy to w kodzie:.
    MISSING VALUES GAP21Q13_b_W82 (99).
    MISSING VALUES GAP21Q46_W82 (99).
    MISSING VALUES F_PARTY_FINAL (4,99).
    MISSING VALUES F_GENDER (3,99).

    * Test zgodności Chi-kwadrat - hipoteza zerowa: Częstotliwości wystąpień odpowiedzi w obydwu grupach są podobne.  

    * Na początek wybierzmy kwestie która dzieli amerykanów - stosunek do służby zdrowia. Wynik testu. 
    CROSSTABS 
      /TABLES=GAP21Q13_b_W82 BY F_PARTY_FINAL 
      /FORMAT=AVALUE TABLES 
      /CELLS=COLUMN 
      /COUNT ROUND CELL
      /STATISTICS=CHISQ.  /*Ten argument różni się od dotyczas używanej funkcji. 

    * Ta sama tabela z innym widokiem. 
   CROSSTABS 
      /TABLES=GAP21Q13_b_W82 BY F_PARTY_FINAL 
      /FORMAT=AVALUE TABLES 
      /CELLS=COUNT EXPECTED RESID 
      /COUNT ROUND CELL
      /STATISTICS=CHISQ.  /*Ten argument różni się od dotyczas używanej funkcji. 

   * Mniej podgrzany podział - przyjmowanie studentów via płeć. 
   CROSSTABS 
      /TABLES=GAP21Q46_W82  BY F_GENDER 
      /FORMAT=AVALUE TABLES 
      /CELLS=COUNT EXPECTED RESID 
      /COUNT ROUND CELL
      /STATISTICS=CHISQ.  /*Ten argument różni się od dotyczas używanej funkcji. 

* 4. Testy statystyczne - Test t.     
    * Hipoteza zerowa - brak różnic, alternatywna różnice. 
    T-TEST GROUPS=F_GENDER(1 2) 
      /MISSING=ANALYSIS 
      /VARIABLES=THERMCHINA_W82 
      /ES DISPLAY(FALSE) 
      /CRITERIA=CI(.95).
    
    * Widok analiza ekstrapolacyjna.
    EXAMINE VARIABLES=THERMCHINA_W82 BY F_GENDER 
      /PLOT BOXPLOT STEMLEAF 
      /COMPARE GROUPS 
      /STATISTICS DESCRIPTIVES 
      /CINTERVAL 95 
      /MISSING LISTWISE 
      /NOTOTAL.

* 5. Testy statystyczne - ANOVA jednoczynnikowa.     
    * Porównanie średnich w kilku grupach - hipoteza zerowa brak różnic, hipoteza alternatywna - różnice w średnich
    
    * Przedstawmy sobie średnie warunkowe. 
     MEANS TABLES=THERMCHINA_W82 BY F_PARTY_FINAL 
          /CELLS=MEAN COUNT STDDEV.

    * Gotowy wydruk ANOVA. 
    ONEWAY THERMCHINA_W82 BY F_PARTY_FINAL 
      /MISSING ANALYSIS 
      /CRITERIA=CILEVEL(0.95).
    

