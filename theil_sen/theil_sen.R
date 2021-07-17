library(deming)

usage = paste(
    sep='\n',
    "ús: Rscript theil_sen.R fitxer.csv [fitxer.pdf]",
    "utilitza la taula de fitxer.csv per estimar l'exponent de la llei de zipf",
    "si s'ha donat fitxer.pdf, genera una gràfica de rang contra frequència amb la coba fitada"
)

#' Calcula l'exponent alpha i la constant A de les dades de la taula utilitzant
#' Theil-Sen.
#' @param table Taula amb columnes tank i freq
#' @return llista amb els paràmetres alpha i A
fit_parameters <- function(table) {
    model <- theilsen(log(rank)~log(freq), table)
    alpha <- coef(model)[[2]]
    A <- exp(coef(model)[[1]])
    list(alpha=alpha, A=A)
}

#' Genera la gràfica a partir d'una taula.
#' @param table Taula amb dades empíriques de freqüència (freq) i rang (rank).
#' @param A constant estimada de les dades de la taula
#' @param alpha constant estimada de les dades de la taula
#' @return Gràfica de ggplot
generate_plot <- function(table, A, alpha) {
    ggplot(table, aes(rank, freq, label=word)) +
        geom_point(aes(shape="circle", fill="solid")) +
        geom_line(aes(y=A*rank^alpha)) +
        scale_x_log10(n.breaks=9) +
        scale_y_log10(n.breaks=9) +
        xlab("rang") +
        ylab("freqüència")
}

if (!interactive()) {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 1 || length(args) > 2) {
        stop(usage)
    }
    
    table <- read.csv(args[1])
    if (length(args) > 1) {
        plot_filename = args[2]
    } else {
        plot_filename = NULL
    }

    params = fit_parameters(table)
    
    cat(paste(
        sep='\n',
        "Estimació dels paràmetres de la llei potencial:",
        paste("alpha =", params$alpha),
        paste("A =", params$A),
        ""
    ))
    
    if (!is.null(plot_filename)) {
        source("../util.R")
        library(ggplot2)
        
        plot <- generate_plot(table, params$A, params$alpha)
        plot <- my_transparent_theme(plot)
        save_figure(plot, plot_filename)
        cat(paste("S'ha generat la gràfica", plot_filename, "\n"))
    }
}
