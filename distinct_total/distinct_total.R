library(ggplot2)

usage = paste(
    sep='\n',
    "ús: Rscript distinct_total.R fitxer.csv fitxer.pdf",
    "utilitza fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera una gràfica mostrant el nombre de paraules totals contra el numbre de paraules úniques"
)

#' Genera la gràfica a partir d'una taula.
#' @param table Taula amb al menys dos columnes: tokens (número total de
#'     paraules) i types (número de paraules úniques).
#' @return Gràfica de ggplot 
generate_plot <- function(table) {
    ggplot(table, aes(tokens, types)) +
        geom_point(aes(shape="circle", fill="solid")) +
        scale_y_log10(n.breaks=9) +
        scale_x_log10(n.breaks=9) +
        xlab("aparicions") +
        ylab("tipus")
}


if (!interactive()) {
    source("../util.R")
    
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) != 2) {
        stop(usage)
    }
    table <- read.csv(args[1])
    outfile <- args[2]

    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    save_figure(plot, outfile)
}
