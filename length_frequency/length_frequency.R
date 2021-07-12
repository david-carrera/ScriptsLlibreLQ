source("../util.R")
library(ggplot2)
library(dplyr)

usage = paste(
    sep='\n',
    "ús: Rscript length_frequency.R fitxer.csv fitxer.pdf [--paraules]",
    "utilitza la taula de fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera ona gràfica en escala logarítmica en ambdos eixos de freqüència contra longitud",
    "amb la opció --paraules algunes de les paraules es mostren a la gràfica (requereix el paquet ggrepel)"
)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
    stop(usage)
} else {
    table <- read.csv(args[1])
    pdffile <- args[2]

    rest <- tail(args, -2)
    words <- "--paraules" %in% rest
    if (words != length(rest)) {
        stop(usage)
    }
}

set.seed(2)
table["length"] = nchar(table[,"word"])
table <- distinct(table, length, freq, .keep_all = TRUE)
ignore_words = sample(
    table[,"word"],
    prob = table[,"length"]**(9/16),
    size = nrow(table)*(6/16)
)
ignore_words <- c(ignore_words, "iii", "n", "s", "d", "l", "contra")
table[table[,"word"] %in% ignore_words,"word"] = ""

plot <- ggplot(table, aes(freq, length, label=word)) +
    geom_point(aes(shape="circle", fill="solid")) +
    xlab("freqüència") +
    ylab("llargada") +
    scale_y_log10(n.breaks=9) +
    scale_x_log10(n.breaks=9)
plot <- my_transparent_theme(plot)

if (words) {
    library(ggrepel)
    
    plot <- plot +
        geom_text_repel(
            min.segment.length = 0,
            max.overlaps = Inf,
            size = 2.5
        )
}

save_figure(plot, pdffile)
