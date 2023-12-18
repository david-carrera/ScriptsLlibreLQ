library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)

usage = paste(
    sep = '\n',
    "ús: Rscript variacio_frequencia.R fitxer.csv fitxer.pdf",
    "utilitza la taula fitxer.csv per crear una figura que desa a fitxer.pdf",
    "el fitxer csv ha de tenir un format year,proportion,ngram de forma que cada fila representa la proporció d'ocurrencies d'una n-grama en un any donat",
    "genera una gràfica mostrant la evolució en populariat d'un o més n-grames amb els anys"
)

#' Calcula la mitjana mòbil del vector l. La mitjana es calcula amb els val
#' valors anteriors, el valor en si, i els val valors següents (2*val + 1
#' valors en total). Si no existeixen prous valors abans o després els valors
#' no s'inclouen a la mitjana.
#' @param l vector de valors
#' @param val mida de la finestra és (2*val + 1) excepte als extrems
#' @return mitjana mòbil de l
moving_average <- function(l, val) {
    n <- length(l)
    i <- 1:n

    ll <- l
    d <- rep(val*2+1, n)
    for (j in 1:val) {
        lafter <- l[i+j]
        lafter[is.na(lafter)] = 0
        ll <- ll + lafter

        lbefore <- l[(i-j)[i-j>0]]
        lbefore <- c(rep(0,j),lbefore)
        ll <- ll + lbefore
        
        d[j] <- d[j] - (val - j + 1)
        d[n-j+1] <- d[n-j+1] - (val - j + 1)
    }

    ll/d
}

#' Aplica la mitjana mòbil a cada n-grama. Afegeix la columna label per a
#' ggrepel, que és el text del n-grama per al últim any. Assegura que hi hagi
#' un valor per a cada n-grama i cada any posant 0 a on faltin valors.
#' @param table taula amb any, n-grama i proporció
#' @param mov_avg_val paràmetre de la mitjana mòbil
#' @return table amb els canvis aplicats
cleanup_table <- function(table, mov_avg_val) {
    table %>%
        tibble %>%
        pivot_wider(
            names_from = ngram,
            values_from = proportion,
            values_fill = 0 # si no hi ha un valor per una combinació de ngram i year, posa-hi 0
        ) %>% # table ara té la forma [year | ngram1 | ngram2 | ...]
        arrange(year) %>% # assegura que estigui ordenada per any abans de fer la mitjana mòbil
        mutate(across(!year, ~moving_average(.x, mov_avg_val))) %>% # aplica la mitjana mòbil a cada columna excepte la de any
        pivot_longer(
            !year,
            names_to = "ngram",
            values_to = "proportion" 
        ) %>% # table torna a tenir la forma [year | proportion | ngram]
        mutate(label = if_else(year == max(year), ngram, "")) # nova columna label és "" per a totes les files excepte la última
}

#' Genera la gràfica a partir d'una taula
#' @param table Taula amb al menys quatre columnes: year, proportion, ngram i
#'     label
#' @return Gràfica de ggplot
generate_plot <- function(table) {
    ## https://ggrepel.slowkow.com/articles/examples.html
    ggplot(table, aes(year, proportion, color = ngram, label = label)) +
        geom_line() +
        coord_cartesian(clip = "off") +
        geom_label_repel(
            max.overlaps = Inf,
            force_pull = 0,
            min.segment.length = Inf,
            direction = "y",
            hjust = 0,
            nudge_x = 5,
            xlim = c(-Inf, Inf)
        ) +
        theme_classic() +
        theme(
            plot.margin = unit(c(0.2, 2.5, 0.2, 0.2), "cm"),
            legend.position = "none",
            panel.background = element_rect(fill = "transparent"),
            plot.background = element_rect(fill = "transparent", color = NA),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
        ) +
        scale_shape_manual(values=c("circle" = 21)) +
        scale_fill_manual(values=c("solid" = "white")) +
        scale_x_continuous(
            n.breaks = 10,
            expand = expansion(mult = 0.01)
        ) +
        scale_y_continuous(
            n.breaks = 10,
            labels = scales::percent
        ) +
        xlab("any") +
        ylab("")
}

if (!interactive()) {
    source("../util.R")
    
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) != 2) {
        stop(usage)
    }

    table <- read.csv(args[[1]])
    outfile <- args[[2]]
    
    table <- cleanup_table(table, 10)
    plot <- generate_plot(table)
    save_figure(plot, outfile, wmult=2)
}
