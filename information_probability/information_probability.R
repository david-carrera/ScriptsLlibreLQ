library(ggplot2)

usage = paste(
    sep='\n',
    "ús: Rscript information_probability.R",
    "genera una gràfica relacionant probabilitat i informació"
)

#' Genera les dades de la gràfica: una taula amb p (probabilitat), I
#' (informació) i pI (probabilitat * informació).
#' @param step Incrementa probabilitat en aquest valor per a cada punt.
#' @return Un data.frame amb les dades
generate_data <- function(step) {
    df <- data.frame(p=seq(step, 1, step))
    df['I'] = -log(df['p'])
    df['pI'] = df['p'] * df['I']
    df
}

#' Genera la gràfica a partir d'una taula.
#' @param table Taula amb al menys dues columnes: I (informació) i pI
#'     (probabilitat * informació).
#' @return Gràfica de ggplot
generate_plot <- function(table) {
    ggplot(table, aes(p)) +
        geom_line(aes(y = I, linetype = 'a')) +
        geom_line(aes(y = pI, linetype = 'c')) +
        xlab("p (probabilitat)") +
        ylab("bits") +
        guides(linetype = FALSE)
}

if (!interactive()) {
    source("../util.R")
    
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) != 0) {
        stop(usage)
    }
    
    table <- generate_data(0.001)
    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    save_figure(plot, "information_probability.png")
}
