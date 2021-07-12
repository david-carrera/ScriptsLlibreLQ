source("../util.R")
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)

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

usage = paste(
    sep = '\n',
    "ús: Rscript variacio_frequencia.R fitxer.csv fitxer.pdf",
    "utilitza la taula fitxer.csv per crear una figura que desa a fitxer.pdf",
    "el fitxer csv ha de tenir un format year,proportion,ngram de forma que cada fila representa la proporció d'ocurrencies d'una n-grama en un any donat",
    "genera una gràfica mostrant la evolució en populariat d'un o més n-grames amb els anys"
)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
    stop(usage)
}

table <- read.csv(args[[1]]) %>%  ## year | proportion | ngram
    tibble %>%
    pivot_wider(
        names_from = ngram,
        values_from = proportion,
        values_fill = 0
    ) %>%  ## year | ngram1 | ngram2 | ...
    arrange(year) %>%
    mutate(across(!year, ~moving_average(.x, 10))) %>%
    ## select(c(year, a, b, c)) %>% ## include only ngrams a, b and c
    pivot_longer(
        !year,
        names_to = "ngram",
        values_to = "proportion" 
    ) %>%  ## year | proportion | ngram
    mutate(label = if_else(year == max(year), ngram, ""))

plot <- ggplot(table, aes(year, proportion, color = ngram, label = label)) +
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
    theme(
        plot.margin = unit(c(0.2, 2.3, 0.2, 0.2), "cm")
    ) +
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
plot <- my_transparent_theme(plot)

save_figure(plot, args[[2]], wmult=2)
