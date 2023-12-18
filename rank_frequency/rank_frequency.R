library(ggplot2)

usage = paste(
    sep='\n',
    "ús: Rscript rank_frequency.R fitxer.csv fitxer.pdf [--loglog --paraules]",
    "utilitza la taula de fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera ona gràfica de rang contra freqüència",
    "amb la opció --loglog ambdos eixos son en escala logaritmica, sense la opció son en escala lineal",
    "amb la opció --paraules algunes de les paraules es mostren a la gràfica (requereix el paquet ggrepel)"
)

#' Elimina el text d'algunes de les paraules de la taula. Les paraules són
#' triades aleatòriament. Disminueix el numero de paraules que ggrepel haurà de
#' dibuixar.
#' @param table taula amb la que operar
#' @return la mateixa taula on algunes de les paraules tenen el seu text buit
ignore_words_randomly <- function(table) {
    l <- unique(round(exp((1:1000)/3)))
    l <- l[l<=nrow(table)]
    tmp <- table[l,"word"]
    table[,"word"] <- ""
    table[l,"word"] <- tmp
    table
}

#' Genera la gràfica a partir d'una taula.
#' @param table Taula amb al menys dos columnes: rank (rang de la paraula) i
#'     freq (freqüència de la paraula)
#' @return Gràfica de ggplot
generate_plot <- function(table) {
    ggplot(table, aes(rank, freq, label=word)) +
        geom_point(aes(shape="circle", fill="solid")) +
        xlab("rang") +
        ylab("freqüència")
}

#' Afegeix les paraules a la gràfica
#' @param plot Gràfica de ggplot
#' @return La mateixa gràfica, amb les paraules afegides
add_words_to_plot <- function(plot) {
    plot +
        geom_text_repel(
            min.segment.length = 0.1,
            max.overlaps = Inf
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
        loglog <- "--loglog" %in% rest
        words <- "--paraules" %in% rest
        if (loglog+words != length(rest)) {
            stop(usage)
        }
    }

    table <- ignore_words_randomly(table)
    
    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    
    if (loglog) {
        plot <- plot + 
            scale_x_log10(n.breaks=9)
        if (!words) {
            plot <- plot + scale_y_log10(n.breaks=9)
        }
    }
    
    if (words) {
        library(ggrepel)
        plot <- add_words_to_plot(plot)
    }
    
    save_figure(plot, outfile)
}
