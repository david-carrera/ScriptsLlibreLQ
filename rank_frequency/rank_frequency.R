source("../util.R")

library(ggplot2)

usage = paste(
    sep='\n',
    "ús: Rscript rank_frequency.R fitxer.csv fitxer.pdf [--loglog --paraules]",
    "utilitza la taula de fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera ona gràfica de rang contra freqüència",
    "amb la opció --loglog ambdos eixos son en escala logaritmica, sense la opció son en escala lineal",
    "amb la opció --paraules algunes de les paraules es mostren a la gràfica (requereix el paquet ggrepel)"
)

## Llegeix comandes
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
    stop(usage)
} else {
    table <- read.csv(args[1])
    pdffile <- args[2]

    rest <- tail(args, -2)
    loglog <- "--loglog" %in% rest
    words <- "--paraules" %in% rest
    if (loglog+words != length(rest)) {
        stop(usage)
    }
}

## Selecciona aleatoriament les paraules que es mostraran
l <- unique(round(exp((1:1000)/3)))
l <- l[l<=nrow(table)]
tmp <- table[l,"word"]
table[,"word"] <- ""
table[l,"word"] <- tmp

## Crea el plot
plot <- ggplot(table, aes(rank, freq, label=word)) +
    geom_point(aes(shape="circle", fill="solid")) +
    xlab("rang") +
    ylab("freqüència")
plot <- my_transparent_theme(plot)

## Cal escala log-log?
if (loglog) {
    plot <- plot + 
        scale_x_log10(n.breaks=9)
    if (!words) {
        plot <- plot + scale_y_log10(n.breaks=9)
    }
}

## Cal afegir les paraules?
if (words) {
    library(ggrepel)
    
    plot <- plot +
        geom_text_repel(
            min.segment.length = 0.1,
            max.overlaps = Inf,
            force = 1,
            force_pull = 1
        ) +
        scale_y_log10(
            n.breaks=9,
            expand = expansion(mult = 0.1)
        )
}

save_figure(plot, pdffile)
