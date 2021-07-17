library(ggplot2)
library(dplyr)

usage = paste(
    sep='\n',
    "ús: Rscript length_frequency.R fitxer.csv fitxer.pdf [--paraules]",
    "utilitza la taula de fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera ona gràfica en escala logarítmica doble de freqüència contra longitud",
    "amb la opció --paraules algunes de les paraules es mostren a la gràfica (requereix el paquet ggrepel)"
)

#' Calcula la longitud de cada paraula de la taula i manté només les entrades
#' que son distintes per frequencia i longitud.
#' @param table taula amb la que operar
#' @return la mateix taula on només queden entrades distintes per la parella
#'     <longitud, freqüència>
filter_distinct <- function(table) {
    table["length"] = nchar(table[,"word"])
    distinct(table, length, freq, .keep_all = TRUE)
}

#' Elimina el text d'algunes de les paraules de la taula. Les paraules són
#' triades aleatòriament. Disminueix el numero de paraules que ggrepel haurà de
#' dibuixar. Les paraules més llargues tendeixen a ser ignorades més, ja que
#' ocupen més espai.
#' @param table taula amb la que operar
#' @return la mateixa taula on algunes de les paraules tenen el seu text buit
ignore_words_randomly <- function(table) {
    ignore_words = sample(
        table[,"word"],
        prob = table[,"length"]**(9/16),
        size = nrow(table)*(6/16)
    )
    ignore_words <- c(ignore_words, "iii", "n", "s", "d", "l", "contra")
    table[table[,"word"] %in% ignore_words,"word"] = ""
    table
}

#' Genera la gràfica a partir d'una taula.
#' @param table Taula amb al menys dos columnes: tokens (número total de
#'     paraules) i types (número de paraules úniques).
#' @return Gràfica de ggplot 
generate_plot <- function(table) {
    ggplot(table, aes(freq, length, label=word)) +
        geom_point(aes(shape="circle", fill="solid")) +
        xlab("freqüència") +
        ylab("llargada") +
        scale_y_log10(n.breaks=9) +
        scale_x_log10(n.breaks=9)
}

#' Afegeix les paraules a la gràfica
#' @param plot Gràfica de ggplot
#' @return La mateixa gràfica, amb les paraules afegides
add_words_to_plot <- function(plot) {
    plot +
        geom_text_repel(
            min.segment.length = 0,
            max.overlaps = Inf,
            size = 2.5
        )
}

if (!interactive()) {
    source("../util.R")
    
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 2) {
        stop(usage)
    } else {
        table <- read.csv(args[1])
        outfile <- args[2]
        
        rest <- tail(args, -2)
        words <- "--paraules" %in% rest
        if (words != length(rest)) {
            stop(usage)
        }
    }

    table <- filter_distinct(table)
    table <- ignore_words_randomly(table)

    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    
    if (words) {
        library(ggrepel)
        plot <- add_words_to_plot(plot)
    }
    
    save_figure(plot, outfile)
}
