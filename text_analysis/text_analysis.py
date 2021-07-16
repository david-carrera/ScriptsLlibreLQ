#!/bin/env python3
# -*- coding: utf-8 -*-

"""Genera un fitxer csv donat un corpus. Pot generar dos tipus de fitxer
diferents.

El primer te tres columnes: el rang de la paraula (on 1 és la
paraula més freqüent), la paraula en si i la seva freqüència (recompte
d'aparicions dins el corpus).

El segon te dues columnes: el nombre de caracters en una paraula i el nombre de
paraules amb aquesta llargada dins el corpus.

"""

import sys
import csv
import argparse
import collections
import string

def get_tokens(f):
    """Tokenitza el text del fitxer donat i retorna la llista de paraules. Paraules
    amb apostrof queden separades per l'apostrof, per exemple: "l'estil" ->
    ["l", "estil"]. Paraules amb un guió es consideren una sola paraula,
    per exemple: "dos-cents" -> ["dos-cents"]

    """
    punctuation_to_remove = string.punctuation.replace("'", "").replace('-','')
    
    tokens = []
    text = f.read().lower()
    for word in text.split():
        # intenta salvar l gemminada
        for c in punctuation_to_remove:
            word = word.replace('l'+c+'l', 'l·l')
            
        word = ''.join(
            c
            for c in word
            if c not in punctuation_to_remove
        )
        
        if word:
            if "'" in word:
                tokens.extend(x for x in word.split("'") if x)
            elif not word.isdigit():
                tokens.append(word)
    return tokens


def analysis_frequencies(tokens, csvwriter):
    """Genera l'analisis de el rang i frequencia de cada paraula en el llistat de
    tokens i escriu el fitxer csv corresponent.

    """
    fdist = collections.Counter(tokens)
    csvwriter.writerow(['rank', 'freq', 'word'])
    analysis = sorted(fdist.items(), key=lambda t: t[1], reverse=True)
    for rang, (paraula, frequencia) in enumerate(analysis):
        csvwriter.writerow([rang+1, frequencia, paraula])


def analysis_distinct_words(tokens, csvwriter):
    """Genera l'analisis del numero de paraules distintes per al nombre de paraules
totals del text.

    """
    counter = collections.Counter()
    csvwriter.writerow(['tokens', 'types'])
    for T in range(1, len(tokens)+1):
        word = tokens[T-1]
        counter[word] += 1
        n = len(counter)
        csvwriter.writerow([T, n])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "fitxer",
        type=argparse.FileType('r'),
        help="fitxer de text amb el text a analitzar"
    )
    parser.add_argument(
        "analisis",
        choices=['freq', 'dist'],
        help="tipus de taula resultant, la frequencia i rang de cada paraula "
        "o el nombre de paraules distintes per cada possible longitud de "
        "paraula"
    )
    parser.add_argument(
        "-o", "--output",
        type=argparse.FileType('w'),
        default=sys.stdout,
        help="fitxer csv a generar, si no s'especifica mostra el fitxer per "
        "pantalla directament"
    )

    args = parser.parse_args()

    tokens = get_tokens(args.fitxer)
    csvwriter = csv.writer(args.output)

    if args.analisis == 'freq':
        analysis_frequencies(tokens, csvwriter)
    else:
        analysis_distinct_words(tokens, csvwriter)
