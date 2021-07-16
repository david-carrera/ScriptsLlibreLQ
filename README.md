# Scripts de Lingüística Quantitativa

Aquest repositori conté els scripts utilitzats per generar part del material
del llibre **Lingüística Quantitativa: L'estadística de les paraules**. Els
scripts estan organitzats en subdirectoris i cadascun conté una breu explicació
sobre el script i cap paquet addicional del que depengui.

No cal ser un expert en programació per tal de jugar i experimentar amb aquests
scripts. Han estat pensats de forma que qualsevol persona amb un nivell bàsic
de coneixement en pugi treure suc. Tots els scripts estan escrits en `python` o
en `R`. Els scripts de `R` generen gràfiques mentre que `python` té un ús més
general. Els scripts de `python` estan fets per a la versió 3 de `python`.

Un bon recurs amb informació sobre com instal·lar paquets addicionals per a
`python` és https://packaging.python.org/tutorials/installing-packages/,
especialment la secció sobre "virtual environments".

## Scripts presents en aquest repositori

La majoria de scripts en aquest repositori estàn relacionats amb la generació
de les figures presents en el llibre. D'altres son "extres" que permeten fer
comprovacions sobre el material.

### Figures del llibre

Els següents scripts generen figures del llibre directament.

* [**Núvol de paraules**](word_cloud) Núvol de les 50 paraules més freqüents en
  la versió catalana de la Declaració dels Drets Humans. Correspon a la figura
  2 del llibre.
  
* [**Relació rang-freqüència**](rank_frequency) Script de `R` que genera les
  gràfiques de rang-freqüència corresponents a les figures 3 i 4 del llibre.
  
* [**Relació entre informació i probabilitat**](information_probability) Un simple
  script de `R` que genera la gràfica de la figura 8 del llibre, mostrant la
  relació entre informació i probabilitat.
  
* [**Relació entre llargada i freqüència dels mots**](length_frequency) Mostra
  totes les paraules d'un text en una gràfica segons la seva llargada i la seva
  freqüència dins el text. En cas de solapament mostra un sol
  punt. Opcionalment pot mostrar el text d'algunes de les paraules. En el
  llibre, és la figura 9
  
* [**Comparació entre la mecanografia aleatòria i la distribució Zeta
  truncada**](typing_zeta) La figura 11 del llibre, comparant la predicció de la
  relació rang-freqüència de la mecanografia aleatòria i de la distribució Zeta
  truncada per la dreta.
  
* [**Nombre de paraules distintes en funció del nombre de paraules
  totals**](differnt_total) Correspon a la figura 12 del llibre, mostrant el
  nombre de paraules diferents en funció del nombre de paraules totals a partir
  d'un text.
  
* [**Comparació de dos models de la probabilitat de la freqüència d'una
  paraula**](compare_frequency_probability) La figura 13 del llibre mostra el
  comportament de dos models de la probabilitat de la freqüència d'una paraula.
  
* [**Evolució de la freqüència de n-grames en el temps**](frequency_evolution)
  Aquest script genera una gràfica que mostra la evolució d'un n-grama en el
  temps. Genera les figures 14 i 15 del llibre.
  
* El fitxer [util.R](util.R) present en aquest directori conté funcions usades
  per tots els scripts de `R` de generació de figures. Conté, per exemple, el
  tema (colors, etc.) comú a totes les figures.
  
### Generació d'altres fitxers

Els següents scripts generen fitxers utilitzats per altres scripts.
  
* [**Anàlisis de text**](text_analysis) Genera fitxers csv a partir de la
  tokenització d'un text donat. Pot generar un fitxer amb el rang i freqüència
  de cada paraula del text o un fitxer amb el nombre de paraules distintes per
  a cada possible longitud de paraula.
  
* [**Extracció de text**](text_extraction) Aquest subdirectori no conté cap script,
  només introdueix un mètode per extreure text de fitxers (per exemple, pdf)
  utilitzant python amb un exemple.
  
### Extres
  
* [**Hapax legomena**](hapax_legomena) Un script de `python` que, donat un csv
  generat de les freqüències de les paraules d'un text, determina si és un
  Hapax Legomena (totes les paraules del text apareixen un sol cop) i si no,
  quines estan repetides.

* [**Theil-Sen**](theil_sen) Aquest script de `R` permet obtenir una estimació de
  l'exponent de la llei de Zipf d'un text. També pot generar una gràfica
  mostrant l'ajustament de la [relació rang-freqüència](rank_frequency) amb la
  llei potencial estimada.
