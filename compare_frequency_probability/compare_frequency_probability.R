source("../util.R")
library(ggplot2)
library(VGAM)

alt_distr <- function(f, beta) {
    f^-(beta-1) - (f+1)^-(beta-1)
}

zeta_distr <- function(f, beta) {
    (1/zeta(beta)) * f^-beta
}

df <- data.frame(freq=1:1000)
df["p_zeta"] <- zeta_distr(df[,"freq"], 2)
df["p_alt"] <- alt_distr(df["freq"], 2)

plot <- ggplot(df, aes(freq)) +
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
plot <- my_transparent_theme(plot)
    
save_figure(plot, "compare_frequency_probability.png")
