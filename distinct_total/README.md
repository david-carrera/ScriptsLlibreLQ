# Nombre de paraules distintes en funció del nombre de paraules totals

Aquest script de `R` mostra la relació entre el número de paraules diferents i
el número de paraules totals d'un text en escala log-log. Correspon a la figura
12 del llibre.

El codi depèn del paquet `ggplot2`, que es pot instal·lar des de una línia de
comandes de `R`:

``` r
install.packages('ggplot2')
```

El script pren com a paràmetre una fitxer csv amb les dades de paraules
distintes i paraules totals d'un text. Aquest repositori inclou un
[script](../text_analysis) de `python` per a generar aquest fitxer a partir
d'un text. El mateix directori inclou el fitxer csv corresponent a la
declaració dels drets humans en català.

Utilitzant aquest fitxer d'exemple, es pot generar una gràfica semblant a la
del llibre:

![Nombre de paraules distintes en funció del nombre de paraules totals](distinct_total.png)

Aquesta gràfica s'ha generat a partir de la següent comanda:

```
Rscript distinct_total.R ../text_analysis/DeclaracioDretsHumansDistintes.csv distinct_total.png
```

La imatge generada no té perquè ser `png`, per exemple `jpg` o `pdf` es poden
generar canviant la extensió del nom del fitxer de sortida.
