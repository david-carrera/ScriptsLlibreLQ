# Evolució de la freqüència de n-grames en el temps

Aquest script genera les figures 14 i 15 del llibre, mostrant la evolució en el
temps d'un conjunt de n-grames.

És un script de `R`, executable amb `Rscript`, que depèn del paquet `ggplot2`,
`dplyr`, `tidyr` i `ggrepel`. Els paquets es poden instal·lar des de una línia
de comandes de `R`:

``` r
install.packages('ggplot2')
```

``` r
install.packages('dplyr')
```

``` r
install.packages(`tidyr`)
```

``` r
install.packages('ggrepel')
```

Per tal d'executar el script, és necessari tenir un fitxer csv amb les dades
sobre la evolució dels n-grames amb el temps. El fitxer ha de contenir tres
columnes per al any, n-grama i proporció (`year`, `proportion` i `ngram`). Cada
fila representa la proporció (freqüència / total) del n-grama en aquell any. Si
no hi ha dades per un any concret, s'interpreta com a proporció zero.

La obtenció d'aquestes dades ja és un tema més complicat. En aquest directori
s'inclouen les dades corresponents en format csv a les figures del llibre, que
s'han obtingut transformant les dades a partir dels format oferts per
[Google_Ngrams](https://books.google.com/ngrams/)
([`zipf_ngrams.csv`](zipf_ngrams.csv)) i pel [CTILC](https://ctilc.iec.cat)
([`catalan_words.csv`](catalan_words.csv)). Cap dels dos serveis ofereix un
sistema oficial per obtenir les dades en un format informàtic. El mètode
d'obtenció d'aquestes dades consisteix en una bona dosi de copiar i enganxar de
les pàgines corresponents i d'aplicar els dos scripts
([`clean_google.py`](clean_google.py) i [`clean_ctilc.py`](clean_ctilc.py))
presents en aquest directori per obtenir els csv en el format desitjat.

A continuació, les dues figures que es poden obtenir a partir de les dades ja
processades presents en aquest directori, similars a les figures 14 i 15 del
llibre.

![Evolució de la freqüència de paraules catalanes](ctilc_frequency_evolution.png)

![Evolució de la freqüència de Llei de Zipf en diversos idiomes](google_frequency_evolution.png)

Aquestes gràfiques s'han generat a partir de les següents comandes:

```
Rscript frequency_evolution.R catalan_words.csv ctilc_frequency_evolution.png
```

```
Rscript frequency_evolution.R zipf_ngrams.csv google_frequency_evolution.png
```
