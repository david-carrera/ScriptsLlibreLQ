# Dades

En aquest directori es troben les dades utilitzades pels scripts. Els
continguts del directori son:

* [**Declaració dels drets humans (PDF)**](DeclaracioDretsHumans.pdf) Un PDF
  amb la declaració dels drets humans en català. Font:
  https://www.ohchr.org/EN/UDHR/Pages/Language.aspx?LangID=cln
  
* [**Declaració dels drets humans (TXT)**](DeclaracioDretsHumans.txt) Un fitxer
  de text amb la declaració dels drets humans en català, extret del
  [PDF](DeclaracioDretsHumans.pdf) utilitzant l'eina descrita a la secció sobre
  [extracció de dades](../text_extraction).

* [**Freqüència de les paraules en la declaració dels drets
  humans**](DeclaracioDretsHumansFrequencies.csv) Un fitxer csv amb el rang de
  freqüència i la freqüència de cadascuna de les paraules presents en la
  declaració dels drets humans. S'ha generat a partir del [text de la
  declaració dels drets humans](DeclaracioDretsHumans.txt) utilitzant el script
  present al directori sobre [analisis de text](../text_analysis).
  
* [**Relació entre numero de paraules distintes i numero de paraules totals en
  la declaració dels drets humans**](DeclaracioDretsHumansDistintes.csv) Un
  fitxer csv amb la relació entre el numero de paraules distintes i totals en
  la declaració dels drets humans, utilitzat per generar [una de la gràfiques
  del llibre](../distinct_total). S'ha generat a partir del [text de la
  declaració dels drets humans](DeclaracioDretsHumans.txt) utilitzant el script
  present al directori sobre [analisis de text](../text_analysis).
  
* [**Text del repte Hapax Legomena**](repte_hl.txt) El text del repte Hapax
  Legomena del llibre.
  
* [**Freqüència de les paraules en el text del repte Hapax
  Legomena**](repte_hl.csv) Un fitxer csv amb el rang de freqüència i la
  freqüència de cadascuna de les paraules presents en el [repte
  HL](repte_hl.txt). Un esperaria que les freqüències sempre siguessin 1. S'ha
  generat utilitzant el script present al directori sobre [analisis de
  text](../text_analysis).
  
* [**Evolució de la freqüència relativa de paraules catalanes amb els
  anys**](catalan_words.csv) Un fitxer CSV que conté la freqüència relativa de
  paraules seleccionades del català en certs anys. Utilitzada per generar la
  gràfica mostrant la [evolució de la freqüència relativa de les
  paraules](../frequency_evolution).
  
* [**Evolució de la freqüència relativa dels n-grames "llei de Zipf" en varis
  idiomes**](zipf_ngrams.csv) Un fitxer CSV que conté la freqüència relativa
  del n-grama "llei de Zipf" en diversos idiomes per a un període
  d'anys. Utilitzada per generar la gràfica mostrant la [evolució de la
  freqüència relativa d'aquests n-grames](../frequency_evolution).

* [**Paraules buides del català**] Un fitxer de text amb les paraules buides (o
  *stop words*) del català. S'inclou una llista de mots buits obtinguda de
  Lluís de Yzaguirre i Maura, director del Laboratori de Tecnologies
  Lingüístiques de l'IULA-UPF (Institut de Lingüística Aplicada de la
  Universitat Pompeu Fabra). La mateixa llista està disponible a
  http://latel.upf.edu/morgana/altres/pub/ca_stop.htm També s'han inclòs totes
  les contraccions del català segons la secció 4.2.1 de la ortografia catalana,
  disponible digitalment a
  https://www.iec.cat/llengua/documents/ortografia_catalana_versio_digital.pdf
  Per simplicitat, paraules ambigües com cap i cal s'han inclòs.
