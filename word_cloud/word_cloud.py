#!/bin/env python3
# -*- coding: utf-8 -*-

"""Genera nuvols de paraules a partir d'un fitxer CSV amb la freqüència de cada
paraula.

"""

import os
import argparse
import csv
import wordcloud


def subscript(n):
    """Crea el caràcter de subscript corresponent a la columna n de l'estandard
    Unicode

    """
    return bytes([0xe2, 0x82, 0x80+n]).decode('utf-8')


def as_subscript(x):
    """Transforma l'enter x a un text entre parentesis fent servir com els
    caràcters Unicode de subscripts.

    """
    s = ''
    while x:
        n = x % 10
        s += subscript(n)
        x //= 10
    return subscript(0xD) + s[::-1] + subscript(0xE)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "input",
        type=argparse.FileType('r'),
        help="fitxer csv amb al menys un a columna per paraules (word) i una "
        "per frequencies (freq)"
    )
    parser.add_argument(
        "output",
        type=argparse.FileType('wb'),
        help="fitxer a on guardar la imatge, el format es detecta per la "
        "extensió"
    )
    parser.add_argument(
        "--paraules-buides",
        help="Un fitxer de text que contingui un llistat de paraules "
        "separades per espais o salts de línia que es pot fer servir "
        "com a paraules buides que no s'inclouen al núvol.",
        default="../dades/paraules_buides.txt"
    )
    parser.add_argument(
        "--mostra-frequencies",
        action="store_true",
        help="afegeix la freqüència de cada paraula"
    )

    # afegeix també els parametres de WordCloud que es fan servir...
    parser.add_argument("--width", type=int, default=500)
    parser.add_argument("--height", type=int, default=500)

    noto_font = '/usr/share/fonts/noto/NotoSans-Regular.ttf'
    if os.path.exists(noto_font):
        default_font_path = noto_font
    else:
        default_font_path = None

    parser.add_argument(
        "--font-path",
        default=default_font_path,
        required=os.name == 'nt',
        help="Aquest parametre és obligatori per a usuaris de Windows. Per a "
        "Linux, el valor per defecte és una font Noto si està instal·lada i, "
        "si no, la font per defecte del paquet wordcloud. És possible que les "
        "freqüències de les paraules no apareixin correctament amb la font "
        "per defecte del paquet."
    )

    parser.add_argument("--margin", type=int, default=10)
    parser.add_argument("--prefer-horizontal", type=float, default=1.0)
    parser.add_argument("--scale", type=float, default=10)
    parser.add_argument("--max-font-size", type=int, default=30)
    parser.add_argument("--relative-scaling", type=float, default=0)
    parser.add_argument("--background-color", default="white")
    parser.add_argument("--max-words", type=int, default=50)

    args = parser.parse_args()

    with open(args.paraules_buides) as f:
        stopwords = set(f.read().split())

    # llegeix el fitxer CSV amb paraules i freqüències tot filtrant les
    # paraules de contingut
    freqDist = {}
    for row in csv.DictReader(args.input):
        word = row['word']
        if word not in stopwords:
            freqDist[word] = int(row['freq'])
    args.input.close()

    # configura el núvol
    wc = wordcloud.WordCloud(
        width=args.width,
        height=args.height,
        font_path=args.font_path,
        margin=args.margin,
        prefer_horizontal=args.prefer_horizontal,
        scale=args.scale,
        max_font_size=args.max_font_size,
        relative_scaling=args.relative_scaling,
        background_color=args.background_color,
        max_words=args.max_words
    )

    # afegeix la frequencia a les paraules
    if args.mostra_frequencies:
        freq = {t+as_subscript(c): c for t, c in freqDist.items()}
    else:
        freq = freqDist

    # genera el núvol i l'escriu al fitxer de sortida
    wc.generate_from_frequencies(freq)
    wc.to_file(args.output)
    args.output.close()
