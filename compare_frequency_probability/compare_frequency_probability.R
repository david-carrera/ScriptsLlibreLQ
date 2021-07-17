library(ggplot2)
library(VGAM)

usage = paste(
    sep='\n',
    "ús: Rscript compare_frequency_probability.R",
    "genera una gràfica relacionant random typing i la distribució zeta"
)

#' Distribució de la probabilitat que una paraula hagi aparegut f vegades.
#' @param f Freqüència, numero de vegades que la paraula apareix.
#' @param beta Parametre de la distribució
#' @return Probabilitat que una paraula apareixi f vegades
zeta_distr <- function(f, beta) {
    (1/zeta(beta)) * f^-beta
}

#' Distribució alternativa de la probabiltat que una paraula hagi aparegut f
#' vegades.
#' @param f Freqüència, numero de vegades que la paraula apareix.
#' @param beta Parametre de la distribució
#' @return Probabilitat que una paraula apareixi f vegades
alt_distr <- function(f, beta) {
    f^-(beta-1) - (f+1)^-(beta-1)
}

#' Genera les dades de la gràfica: una taula amb cada valor de frequència
#' (freq) i la seva probabilitat segons la distribució zeta (p_zeta) o la
#' distribució alternativa (p_alt)
#' @param f_max Genera frequències entre 1 i f_max
#' @param beta Paràmetre de les distribucions
generate_data <- function(f_max, beta) {
    df <- data.frame(freq=1:f_max)
    df["p_zeta"] <- zeta_distr(df["freq"], beta)
    df["p_alt"] <- alt_distr(df["freq"], beta)
    df
}

#' Genera la gràfica a partir d'una taula
#' @param table Taula amb al menys tres columnes: freq, p_zeta (probabilitat de
#'     freq segons la distribució zeta) i p_alt (probabilitat de freq segons la
#'     distribució alternativa).
#' @return Gràfica de ggplot
generate_plot <- function(table) {
    ggplot(table, aes(freq)) +
        geom_line(aes(y = p_zeta), linetype = 1) +
        geom_line(aes(y = p_alt), linetype = 2) +
        scale_y_log10(
            n.breaks=7,
            labels = scales::trans_format("log10", scales::math_format(10^.x))
        ) +
        scale_x_log10(
            labels = scales::trans_format("log10", scales::math_format(10^.x))
        ) +
        ylab("probabilitat") +
        xlab("freqüència")
}

if (!interactive()) {
    source("../util.R")
    
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) != 0) {
        stop(usage)
    }
    
    table <- generate_data(1000, 2)
    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    save_figure(plot, "compare_frequency_probability.png")
}
