library(ggplot2)
library(purrr)

usage = paste(
    sep='\n',
    "ús: Rscript typing_zeta.R",
    "genera una gràfica relacionant random typing i la distribució zeta"
)

#' Distribució zeta truncada per la dreta de la freqüència donat un rang.
#' @param r Rang
#' @param r_max Paràmetre de la distribució (r a on truncar)
#' @param gamma Paràmetre de la distribució (exponent)
#' @return freqüència corresponent al rang r
right_truncated_zeta <- function(r, r_max, gamma) {
    1/sum((1:r_max)^(-gamma)) * r^(-gamma)
}

#' Distribució random typing de la freqüència donat un rang.
#' @param r Rang
#' @param N Paràmetre de la distribució (número de lletres al alfabet)
#' @param pi Paràmetre de la distribució (probabilitat d'un espai)
#' @return freqüència corresponent al rang r
random_typing <- function(r, N, pi) {
    l <- map_int(r, ~which(.x <= N^(1:5))[[1]])
    ((1-pi)^(l-1) * pi) / N^l
}

#' Genera les dades de la gràfica: una taula amb la probabilitat segons la
#' distribució zeta i segons la probabilitat segons distribució de random
#' typing per a cada rang entre 1 i max_rank.
#' @param max_rank Genera probabilitats per a rangs 1 a max_rank
#' @param r_max Paràmetre de la distribució zeta
#' @param gamma Paràmetre de la distribució zeta
#' @param N Paràmetre de la distribució random typing
#' @param pi Paràmetre de la distribució random typing
generate_data <- function(max_rank, r_max, gamma, N, pi) {
    df <- data.frame(rank=1:max_rank)
    df["p_zeta"] <- right_truncated_zeta(df["rank"], r_max, gamma)
    df["p_typing"] <- random_typing(df[,"rank"], N, pi)
    df
}

#' Genera la gràfica a partir d'una taula
#' @param table Taula amb al menys tres columnes: rank, p_zeta (probabilitat de
#'     rank segons la distribució zeta) i p_typing (probabilitat de rank segons
#'     la distribució random typing).
#' @return Gràfica de ggplot
generate_plot <- function(table) {
    ggplot(table, aes(rank)) +
        geom_line(aes(y = p_typing)) +
        geom_point(aes(y = p_zeta, shape = "circle", fill = 'solid')) +
        scale_y_log10(
        n.breaks = 5,
        labels = scales::trans_format("log10", scales::math_format(10^.x))
        ) +
        scale_x_log10(
            n.breaks = 5,
            labels = scales::trans_format("log10", scales::math_format(10^.x))
        ) +
        xlab("rang") +
        ylab("probabilitat")
}

if (!interactive()) {
    source("../util.R")
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args != 1)) {
        stop(usage)
    }
    table <- generate_data(1500, 10000, 1, 26, 0.18)
    plot <- generate_plot(table)
    plot <- my_transparent_theme(plot)
    save_figure(plot, "typing_zeta.png")
}
