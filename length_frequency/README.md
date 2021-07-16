# Relació entre llargada i freqüència dels mots

Aquest script de `R` mostra la relació entre freqüència i llargada dels mots
d'un text en escala doble logarítmica. A més, també pot mostrar alguns dels
mots dins la gràfica. Correspon a la figura 9 del llibre.

El script depèn dels paquets `ggplot2`, `dplyr` i, opcionalment si es volen
mostrar les paraules, del paquet `ggrepel` que es poden instal·lar des de una
línia de comandes de `R`:

``` r
install.packages('ggplot2')
```

``` r
install.packages('dplyr')
```

``` r
install.packages('ggrepel')
```

El script pren com a paràmetre una fitxer csv amb la freqüència de cadascuna de
les paraules d'un text. Aquest repositori inclou un [script](../text_analysis)
de `python` per a generar aquest fitxer a partir d'un text. El mateix directori
inclou el fitxer csv corresponent a la declaració dels drets humans en català.

Utilitzant aquest fitxer d'exemple, es pot generar una gràfica semblant a la
del llibre:

![Relació entre llargada i freqüència dels mots](length_frequency.png)

Aquesta gràfica s'ha generat a partir de la següent comanda:

```
Rscript length_frequency.R ../text_analysis/DeclaracioDretsHumansFrequencies.csv length_frequency.png --paraules
```

La opció `--paraules` resulta en un error si el paquet `ggrepel` no està
instal·lat. La imatge generada no té perquè ser `png`, per exemple `jpg` o
`pdf` es poden generar canviant la extensió del nom del fitxer de sortida.
