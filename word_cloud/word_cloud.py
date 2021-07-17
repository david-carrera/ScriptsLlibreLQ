#!/bin/env python3
# -*- coding: utf-8 -*-

"""Genera nuvols de paraules a partir d'un fitxer CSV amb la freqüència de cada
paraula.

"""

import os
import argparse
import csv
import wordcloud

# Aquesta llista de mots buits del català ha estat obtinguda de Lluís de
# Yzaguirre i Maura, director del Laboratori de Tecnologies Lingüístiques de
# l'IULA-UPF (Institut de Lingüística Aplicada de la Universitat Pompeu Fabra)
#
# http://latel.upf.edu/morgana/altres/pub/ca_stop.htm
# (2021-07-05)
STOPWORDS_CAT = set([
    'a', 'abans', "abans-d'ahir", 'abintestat', 'ací', 'adesiara', 'adés',
    'adéu', 'adàgio', 'ah', 'ahir', 'ai', 'aitambé', 'aitampoc', 'aitan',
    'aitant', 'aitantost', 'aixà', 'això', 'així', 'aleshores', 'algun',
    'alguna', 'algunes', 'alguns', 'algú', 'alhora', 'allà', 'allèn', 'allò',
    'allí', 'almenys', 'alto', 'altra', 'altre', 'altres', 'altresí', 'altri',
    'alça', 'al·legro', 'amargament', 'amb', 'ambdues', 'ambdós', 'amunt',
    'amén', 'anc', 'andante', 'andantino', 'anit', 'ans', 'antany', 'apa',
    'aprés', 'aqueix', 'aqueixa', 'aqueixes', 'aqueixos', 'aqueixs', 'aquell',
    'aquella', 'aquelles', 'aquells', 'aquest', 'aquesta', 'aquestes',
    'aquests', 'aquèn', 'aquí', 'ara', 'arran', 'arrera', 'arrere', 'arreu',
    'arri', 'arruix', 'atxim', 'au', 'avall', 'avant', 'aviat', 'avui', 'açò',
    'bah', 'baix', 'baldament', 'ballmanetes', 'banzim-banzam', 'bastant',
    'bastants', 'ben', 'bis', 'bitllo-bitllo', 'bo', 'bé', 'ca', 'cada', 'cal',
    'cap', 'car', 'caram', 'catorze', 'cent', 'centes', 'cents', 'cerca',
    'cert', 'certa', 'certes', 'certs', 'cinc', 'cinquanta', 'cinquena',
    'cinquenes', 'cinquens', 'cinquè', 'com', 'comsevulla', 'contra',
    'cordons', 'corrents', 'cric-crac', 'd', 'daixonses', 'daixò', 'dallonses',
    'dallò', 'dalt', 'daltabaix', 'damunt', 'darrera', 'darrere', 'davall',
    'davant', 'de', 'debades', 'dedins', 'defora', 'dejorn', 'dejús', 'dellà',
    'dementre', 'dempeus', 'demés', 'demà', 'des', 'desena', 'desenes',
    'desens', 'després', 'dessobre', 'dessota', 'dessús', 'desè', 'deu',
    'devers', 'devora', 'deçà', 'diferents', 'dinou', 'dins', 'dintre',
    'disset', 'divers', 'diversa', 'diverses', 'diversos', 'divuit', 'doncs',
    'dos', 'dotze', 'dues', 'durant', 'ecs', 'eh', 'el', 'ela', 'elis', 'ell',
    'ella', 'elles', 'ells', 'els', 'em', 'emperò', 'en', 'enans', 'enant',
    'encara', 'encontinent', 'endalt', 'endarrera', 'endarrere', 'endavant',
    'endebades', 'endemig', 'endemés', 'endemà', 'endins', 'endintre',
    'enfora', 'engir', 'enguany', 'enguanyasses', 'enjús', 'enlaire', 'enlloc',
    'enllà', 'enrera', 'enrere', 'ens', 'ensems', 'ensota', 'ensús', 'entorn',
    'entre', 'entremig', 'entretant', 'entrò', 'envers', 'envides', 'environs',
    'enviró', 'ençà', 'ep', 'ep', 'era', 'eren', 'eres', 'ergo', 'es', 'escar',
    'essent', 'esser', 'est', 'esta', 'estada', 'estades', 'estan', 'estant',
    'estar', 'estaran', 'estarem', 'estareu', 'estaria', 'estarien',
    'estaries', 'estaré', 'estarà', 'estaràs', 'estaríem', 'estaríeu', 'estat',
    'estats', 'estava', 'estaven', 'estaves', 'estem', 'estes', 'esteu',
    'estic', 'estiguem', 'estigueren', 'estigueres', 'estigues', 'estiguessis',
    'estigueu', 'estigui', 'estiguin', 'estiguis', 'estigué', 'estiguérem',
    'estiguéreu', 'estigués', 'estiguí', 'estos', 'està', 'estàs', 'estàvem',
    'estàveu', 'et', 'etc', 'etcètera', 'ets', 'excepte', 'fins', 'fora',
    'foren', 'fores', 'força', 'fos', 'fossin', 'fossis', 'fou', 'fra', 'fui',
    'fóra', 'fórem', 'fóreu', 'fóreu', 'fóssim', 'fóssiu', 'gaire', 'gairebé',
    'gaires', 'gens', 'girientorn', 'gratis', 'ha', 'hagi', 'hagin', 'hagis',
    'haguda', 'hagudes', 'hagueren', 'hagueres', 'haguessin', 'haguessis',
    'hagut', 'haguts', 'hagué', 'haguérem', 'haguéreu', 'hagués', 'haguéssim',
    'haguéssiu', 'haguí', 'hala', 'han', 'has', 'hauran', 'haurem', 'haureu',
    'hauria', 'haurien', 'hauries', 'hauré', 'haurà', 'hauràs', 'hauríem',
    'hauríeu', 'havem', 'havent', 'haver', 'haveu', 'havia', 'havien',
    'havies', 'havíem', 'havíeu', 'he', 'hem', 'heu', 'hi', 'ho', 'hom', 'hui',
    'hàgim', 'hàgiu', 'i', 'igual', 'iguals', 'inclusive', 'ja', 'jamai', 'jo',
    'l', 'la', 'leri-leri', 'les', 'li', 'lla', 'llavors', 'llevat', 'lluny',
    'llur', 'llurs', 'lo', 'los', 'ls', 'm', 'ma', 'mai', 'mal', 'malament',
    'malgrat', 'manco', 'mant', 'manta', 'mantes', 'mantinent', 'mants',
    'massa', 'mateix', 'mateixa', 'mateixes', 'mateixos', 'me', 'mentre',
    'mentrestant', 'menys', 'mes', 'meu', 'meua', 'meues', 'meus', 'meva',
    'meves', 'mi', 'mig', 'mil', 'mitges', 'mitja', 'mitjançant', 'mitjos',
    'moixoni', 'molt', 'molta', 'moltes', 'molts', 'mon', 'mos', 'més', 'n',
    'na', 'ne', 'ni', 'ningú', 'no', 'nogensmenys', 'només', 'noranta', 'nos',
    'nosaltres', 'nostra', 'nostre', 'nostres', 'nou', 'novena', 'novenes',
    'novens', 'novè', 'ns', 'nòs', 'nós', 'o', 'oh', 'oi', 'oidà', 'on',
    'onsevulga', 'onsevulla', 'onze', 'pas', 'pengim-penjam', 'per', 'perquè',
    'pertot', 'però', 'piano', 'pla', 'poc', 'poca', 'pocs', 'poques',
    'potser', 'prest', 'primer', 'primera', 'primeres', 'primers', 'pro',
    'prompte', 'prop', 'prou', 'puix', 'pus', 'pàssim', 'qual', 'quals',
    'qualsevol', 'qualsevulla', 'qualssevol', 'qualssevulla', 'quan', 'quant',
    'quanta', 'quantes', 'quants', 'quaranta', 'quart', 'quarta', 'quartes',
    'quarts', 'quasi', 'quatre', 'que', 'quelcom', 'qui', 'quin', 'quina',
    'quines', 'quins', 'quinze', 'quisvulla', 'què', 'ran', 're', 'rebé',
    'renoi', 'rera', 'rere', 'res', 'retruc', 's', 'sa', 'salvament',
    'salvant', 'salvat', 'se', 'segon', 'segona', 'segones', 'segons',
    'seguida', 'seixanta', 'sempre', 'sengles', 'sens', 'sense', 'ser',
    'seran', 'serem', 'sereu', 'seria', 'serien', 'series', 'seré', 'serà',
    'seràs', 'seríem', 'seríeu', 'ses', 'set', 'setanta', 'setena', 'setenes',
    'setens', 'setze', 'setè', 'seu', 'seua', 'seues', 'seus', 'seva', 'seves',
    'si', 'sia', 'siau', 'sic', 'siguem', 'sigues', 'sigueu', 'sigui',
    'siguin', 'siguis', 'sinó', 'sis', 'sisena', 'sisenes', 'sisens', 'sisè',
    'sobre', 'sobretot', 'sol', 'sola', 'solament', 'soles', 'sols', 'som',
    'son', 'sos', 'sota', 'sots', 'sou', 'sovint', 'suara', 'sí', 'sóc', 'són',
    't', 'ta', 'tal', 'tals', 'també', 'tampoc', 'tan', 'tanmateix', 'tant',
    'tanta', 'tantes', 'tantost', 'tants', 'te', 'tercer', 'tercera',
    'terceres', 'tercers', 'tes', 'teu', 'teua', 'teues', 'teus', 'teva',
    'teves', 'ton', 'tos', 'tost', 'tostemps', 'tot', 'tota', 'total', 'totes',
    'tothom', 'tothora', 'tots', 'trenta', 'tres', 'tret', 'tretze', 'tu',
    'tururut', 'u', 'uf', 'ui', 'uix', 'ultra', 'un', 'una', 'unes', 'uns',
    'up', 'upa', 'us', 'va', 'vagi', 'vagin', 'vagis', 'vaig', 'vair', 'vam',
    'van', 'vares', 'vas', 'vau', 'vem', 'verbigràcia', 'vers', 'vet', 'veu',
    'vint', 'vora', 'vos', 'vosaltres', 'vostra', 'vostre', 'vostres', 'vostè',
    'vostès', 'vuit', 'vuitanta', 'vuitena', 'vuitenes', 'vuitens', 'vuitè',
    'vés', 'vàreig', 'vàrem', 'vàreu', 'vós', 'xano-xano', 'xau-xau', 'xec',
    'érem', 'éreu', 'és', 'ésser', 'àdhuc', 'àlies', 'ça', 'ço', 'òlim',
    'ídem', 'últim', 'última', 'últimes', 'últims', 'únic', 'única', 'únics',
    'úniques'
])

# Contraccions del català segons la secció 4.2.1 de la ortografia catalana
# Versió digital:
#   https://www.iec.cat/llengua/documents/ortografia_catalana_versio_digital.pdf
# Visitada el 2021-07-17
STOPWORDS_CAT.update(set([
    'al', 'als', 'del', 'dels', 'pel', 'pels', 'cal', 'cals', 'can', 'as',
    'des', 'pes', 'cas', 'son', 'sul', 'suls'
])

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
        help="Aquest parametre és obligatori per a usuaris de Windows. "
        "Per a Linux, el valor per defecte és una font Noto si està instal·lada "
        "i, si no, la font per defecte del paquet wordcloud. És possible que les "
        "freqüències de les paraules no apareixin correctament amb la font per "
        "defecte del paquet."
    )
    
    parser.add_argument("--margin", type=int, default=10)
    parser.add_argument("--prefer-horizontal", type=float, default=1.0)
    parser.add_argument("--scale", type=float, default=10)
    parser.add_argument("--max-font-size", type=int, default=30)
    parser.add_argument("--relative-scaling", type=float, default=0)
    parser.add_argument("--background-color", default="white")
    parser.add_argument("--max-words", type=int, default=50)

    args = parser.parse_args()

    # llegeix el fitxer CSV amb paraules i freqüències tot filtrant les
    # paraules de contingut
    freqDist = {}
    for row in csv.DictReader(args.input):
        word = row['word']
        if word not in STOPWORDS_CAT:
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
