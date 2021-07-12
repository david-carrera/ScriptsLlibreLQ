# Relació entre llargada i freqüència dels mots

Aquest script genera la figura 9 del llibre, mostrant la relació entre
freqüència i llargada dels mots d'un text en escala doble logarítmica. A més,
també pot mostrar el lloc d'alguns dels mots dins la gràfica.

És un script de `R`, executable amb `Rscript`, que depèn del paquet `ggplot2`,
`dplyr` i, opcionalment, del paquet `ggrepel`. Els paquets es poden instal·lar
des de una línia de comandes de `R`:

``` r
install.packages('ggplot2')
```

``` r
install.packages('dplyr')
```

``` r
install.packages('ggrepel')
```

Per tal d'executar el script, és necessari tenir un fitxer csv amb les paraules
d'un text i les seves freqüències. Un fitxer d'exemple per a la declaració dels
drets humans, així com un script per generar fitxers semblants per a qualsevol
text, es pot trobar dins el subdirectori d'[anàlisis de text](../text_analysis).

Com a exemple, una gràfica semblant a la que apareix en el llibre:

![Relació entre llargada i freqüència dels mots](length_frequency.png)

Aquesta gràfica s'ha generat a partir de la següent comanda:

```
Rscript length_frequency.R ../text_analysis/DeclaracioDretsHumansFrequencies.csv length_frequency.png --paraules
```

La opció `--paraules` resulta en un error si el paquet `ggrepel` no està
instal·lat. La imatge generada no té perquè ser `png`, per exemple `jpg` o
`pdf` es poden generar canviant la extensió del nom del fitxer de sortida.
