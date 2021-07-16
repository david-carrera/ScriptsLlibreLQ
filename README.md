# Scripts de Lingüística Quantitativa

Aquest repositori conté els scripts utilitzats per generar part del material
del llibre **Lingüística Quantitativa: L'estadística de les paraules**. Els
scripts estan organitzats en subdirectoris. Cada subdirectori conté una breu
descripció del script: paquets addicional del que pugui dependre, indicacions
sobre com executar-lo, etc.

No cal ser un expert en programació per tal de jugar i experimentar amb aquests
scripts. Han estat pensats de forma que qualsevol persona amb un nivell bàsic
de coneixement en pugi treure suc. Tots els scripts estan escrits en `python` o
en `R`. Els scripts de `R` generen gràfiques mentre que `python` té un ús més
general. Els scripts de `python` estan pensats per a la versió 3 de `python`,
executar-los amb la versió 2 pot resultar en errors.

Un bon recurs amb informació sobre com instal·lar paquets addicionals per a
`python` és https://packaging.python.org/tutorials/installing-packages/,
especialment la secció sobre *virtual environments*.

## Scripts presents en aquest repositori

La majoria de scripts en aquest repositori estan relacionats amb la generació
de les figures del llibre. Molts d'ells utilitzen `R` per a la generació de
figures. D'altres son "extres" que permeten fer comprovacions sobre el
material o generar fitxers intermedis i que solen estar en `python`.

### Figures del llibre

Els següents scripts generen figures del llibre directament. La majoria
utilitzen `R`.

* [**Núvol de paraules**](word_cloud) Núvol de les 50 paraules més freqüents en
  la versió catalana de la Declaració dels Drets Humans. Correspon a la figura
  2 del llibre. Aquest script està escrit en `python`.
  
* [**Relació rang-freqüència**](rank_frequency) Genera gràfiques de la
  freqüència d'una paraula en funció del seu rang. Opcionalment pot mostrar
  algunes de les paraules com a exemples. Correspon a les figures 3 i 4 del
  llibre.
  
* [**Relació entre informació i probabilitat**](information_probability) Genera
  una gràfica de la probabilitat en funció de la informació. Correspon a la
  figura 8 del llibre.
  
* [**Relació entre llargada i freqüència dels mots**](length_frequency) Dibuixa
  en un pla punts corresponents a les paraules d'un text. L'eix x n'indica la
  freqüència i l'eix y la llargada. Opcionalment pot mostrar algunes de les
  paraules junt amb els punts. Correspon a la figura 9 del llibre.
  
* [**Comparació entre la mecanografia aleatòria i la distribució Zeta
  truncada**](typing_zeta) Genera una gràfica comparant el model de
  mecanografia aleatòria amb el model de la distribució Zeta truncada per la
  dreta. Correspon a la figura 11 del llibre.
  
* [**Nombre de paraules distintes en funció del nombre de paraules
  totals**](distinct_total) Genera una gràfica mostrant el número de paraules
  úniques (tipus) en funció del número de paraules totals (aparicions) d'un
  text. Correspon a la figura 12 del llibre.
  
* [**Comparació de dos models de la probabilitat de la freqüència d'una
  paraula**](compare_frequency_probability) Genera una gràfica mostrant dos
  models de la probabilitat de la freqüència de les paraules. Correspon a la
  figura 13.
  
* [**Evolució de la freqüència de n-grames en el temps**](frequency_evolution)
  Genera una gràfica mostrant la evolució de la freqüència (en percentage) d'un
  o més n-grames en el temps. Correspón a les figures 14 i 15 del llibre.
  
* El fitxer [util.R](util.R) present en aquest directori conté funcions usades
  per tots els scripts de `R` de generació de figures. Per exemple, el tema
  (colors, etc.) comú a totes les figures.
  
### Extres
  
* [**Hapax legomena**](hapax_legomena) Un script de `python` que per determinar
  si un text és un Hapax Legomena (totes les paraules del text apareixen un sol
  cop) i si no ho és, quines paraules estan repetides.

* [**Theil-Sen**](theil_sen) Aquest script de `R` permet obtenir una estimació de
  l'exponent de la llei de Zipf d'un text. També pot generar una gràfica
  mostrant l'ajustament de la [relació rang-freqüència](rank_frequency) amb la
  llei potencial estimada.
  
### Generació d'altres fitxers

Els següents scripts generen fitxers utilitzats per altres scripts.
  
* [**Anàlisis de text**](text_analysis) Aquest script de `python` genera
  fitxers csv a partir de la tokenització d'un text donat. Pot generar un
  fitxer amb el rang i freqüència de cada paraula del text o un fitxer amb el
  nombre de paraules distintes per a cada possible longitud de paraula. Totes
  les gràfiques generades a partir d'un text utilitzen un d'aquests fitxers.
  
* [**Extracció de text**](text_extraction) Aquest subdirectori no conté cap
  script, però introdueix un mètode per extreure text de una gran varietat de
  tipus de fitxers (incloent pdfs). Utilitza `python`.
