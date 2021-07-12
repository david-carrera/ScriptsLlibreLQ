source("../util.R")
library(ggplot2)
library(purrr)

right_truncated_zeta <- function(r, r_max, gamma) {
    1/sum((1:r_max)^(-gamma)) * r^(-gamma)
}

random_typing <- function(r, N, pi) {
    l <- map_int(r, ~which(.x <= N^(1:5))[[1]])
    ((1-pi)^(l-1) * pi) / N^l
}

df <- data.frame(rank=1:1500)
df["p_zeta"] <- right_truncated_zeta(df["rank"], 10000, 1)
df["p_typing"] <- random_typing(df[,"rank"], 26, 0.18)

plot <- ggplot(df, aes(rank)) +
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
plot <- my_transparent_theme(plot)

save_figure(plot, "typing_zeta.png")
