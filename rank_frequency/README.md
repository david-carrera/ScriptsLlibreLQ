# Relació Rang-Freqüència

Aquest script genera les figures 3 i 4 del llibre, unes gràfiques de relació
rang-freqüència. També mostra el lloc d'algunes paraules dins la gràfica.

És un script de `R`, executable amb `Rscript`, que depèn del paquet `ggplot2` i,
opcionalment, del paquet `ggrepel`. Els paquets es poden instal·lar des de una
línia de comandes de `R`:

``` r
install.packages('ggplot2')
```

``` r
install.packages('ggrepel')
```

Per tal d'executar el script, és necessari tenir un fitxer csv amb les paraules
d'un text i les seves freqüències. Un fitxer d'exemple per a la declaració dels
drets humans, així com un script per generar fitxers semblants per a qualsevol
text, es pot trobar dins el subdirectori d'[anàlisis de text](../text_analysis).

Com a exemple, dues gràfiques semblants a les que apareixen en el llibre. En escala lineal:

![Relació rang-freqüència de les paraules en la declaració dels drets humans](rank_frequency.png)

I en escala logarítmica:

![Relació rang-freqüència de les paraules en la declaració dels drets humans en escala logarítmica](rank_frequency_loglog.png)

Aquestes gràfiques s'han generat a partir de les següents comandes, respectivament:

```
Rscript rank_frequency.R ../text_analysis/DeclaracioDretsHumansFrequencies.csv rank_frequency.png --paraules
```

```
Rscript rank_frequency.R ../text_analysis/DeclaracioDretsHumansFrequencies.csv rank_frequency_loglog.png --paraules --loglog
```

La opció `--paraules` resulta en un error si el paquet `ggrepel` no està
instal·lat. La imatge generada no té perquè ser `png`, per exemple `jpg` o
`pdf` es poden generar canviant la extensió del nom del fitxer de sortida.
